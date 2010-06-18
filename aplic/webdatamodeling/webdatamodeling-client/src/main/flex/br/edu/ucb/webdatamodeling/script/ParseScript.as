package br.edu.ucb.webdatamodeling.script
{
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import br.edu.ucb.webdatamodeling.dto.MerDTO;
	import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class ParseScript
	{
		// constantes de string comuns
		private static const BLANK_SPACE:String = " ";
		private static const TAB_SPACE:String = "	";
		private static const ABRE_PARENTESE:String = "(";
		private static const FECHA_PARENTESE:String = ")";
		private static const VIRGULA:String = ",";
		private static const PONTO_VIRGULA:String = ";";
		private static const CARRIAGE_RETURN:String = "\n";
		private static const CREATE_TABLE:String = "CREATE TABLE";
		
		private static var _instance:ParseScript;
		
		private var _query:String;
		
		private var _highlight:Boolean;
		
		private var _scriptsAlterTableFKs:ArrayCollection;
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
			
		public function ParseScript()
		{
			_query = new String();
		}
		
		public static function getInstance():ParseScript
		{
			if (_instance == null)
			{
				_instance = new ParseScript();
			}
			return _instance;
		}

		private function createComentarioInicial(mer:MerDTO):void
		{
			_query = "/*==============================================================*/";
			_query += CARRIAGE_RETURN;
			_query += "/* MER: " + mer.arquivo.descricao + "                          */";
			_query += CARRIAGE_RETURN;
			_query += "/*==============================================================*/";
			_query += CARRIAGE_RETURN;
			_query += CARRIAGE_RETURN;
			_query += CARRIAGE_RETURN;
		}
		
		private function createComentarioTabela(tabela:TabelaDTO):void
		{
			_query += "-- Tabela: " + tabela.descricao;
			_query += CARRIAGE_RETURN;
		}
		
		private function createTabela(tabela:TabelaDTO):void
		{
			_query += CREATE_TABLE;
			_query += BLANK_SPACE;
			_query += tabela.descricao;
			_query += BLANK_SPACE;
			_query += ABRE_PARENTESE;
			_query += CARRIAGE_RETURN;
		}
		
		private function createCampos(tabela:TabelaDTO):void
		{
			for each(var campo:CampoDTO in tabela.campos)
			{
				_query += TAB_SPACE;
				_query += campo.descricao;
				_query += BLANK_SPACE;
				_query += campo.tipo.descricao;
				_query += BLANK_SPACE;
				_query += ABRE_PARENTESE;
				_query += campo.tamanho;
				_query += FECHA_PARENTESE;
				_query += VIRGULA;
				_query += CARRIAGE_RETURN;
			}
		}
		
		private function createConstraints(tabela:TabelaDTO):void
		{
			_query += TAB_SPACE;
			_query += "CONSTRAINT PK_" + tabela.descricao.toUpperCase();
			_query += " PRIMARY KEY (";
			
			for each (var campo:CampoDTO in tabela.campos)
			{
				if (campo.chavePrimaria)
				{
					_query += campo.descricao;
				}
			}
			
			_query += ")";
			_query += CARRIAGE_RETURN;
		}
	
		private function createEndTable():void
		{
			_query += FECHA_PARENTESE;
			_query += PONTO_VIRGULA;
			_query += CARRIAGE_RETURN + CARRIAGE_RETURN;
		}
		
		public function parserScript(mer:MerDTO, highlight:Boolean = false):String
		{
			_highlight = highlight;
			
			if (mer != null && mer.tabelas != null && mer.tabelas.length > 0)
			{
				_query = "";
				
				createComentarioInicial(mer);
				
				for each (var tabela:TabelaDTO in mer.tabelas)
				{
					createComentarioTabela(tabela);
					createTabela(tabela);
					createCampos(tabela);
					createConstraints(tabela);
					createEndTable();
				}
				
				//createForeingKeys(mer);
			}
			
			return _query;
		}
		
	}
}