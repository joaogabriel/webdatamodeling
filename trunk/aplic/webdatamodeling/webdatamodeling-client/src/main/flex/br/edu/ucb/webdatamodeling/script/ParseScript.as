package br.edu.ucb.webdatamodeling.script
{
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import br.edu.ucb.webdatamodeling.dto.MerDTO;
	import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
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
		private static const ALTER_TABLE:String = "ALTER TABLE";
		private static const CONSTRAINT:String = "CONSTRAINT";
		private static const PRIMARY_KEY:String = "PRIMARY KEY";
		private static const NOT_NULL:String = "NOT NULL";
		private static const DEFAULT_CONSTRAINT:String = "ON DELETE RESTRICT ON UPDATE RESTRICT";
		private static const ADD_CONSTRAINT:String = "ADD CONSTRAINT";
		private static const REFERENCES:String = "REFERENCES";
		
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
			_query = "/*=============================================*/";
			_query += CARRIAGE_RETURN;
			_query += "/* SCRIPT GERADO A PARTIR DO WEB DATA MODELING				*/";
			_query += CARRIAGE_RETURN;
			_query += "/* DATA: " + novaData() + "													*/";
			_query += CARRIAGE_RETURN;
			_query += "/*=============================================*/";
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
			_query += createHighlight(CREATE_TABLE, _highlight);
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
				
				if (campo.tipo.descricao != "BOOLEAN" && campo.tipo.descricao != "DATE" && campo.tipo.descricao != "SERIAL") {
					_query += ABRE_PARENTESE;
					_query += campo.tamanho;
					_query += FECHA_PARENTESE;
				}
				
				if (campo.naoNulo) {
					_query += BLANK_SPACE;
					_query += NOT_NULL;
				}
				
				_query += VIRGULA;
				_query += CARRIAGE_RETURN;
			}
		}
		
		private function createConstraints(tabela:TabelaDTO):void
		{
			_query += TAB_SPACE;
			_query += createHighlight(CONSTRAINT, _highlight);
			_query += BLANK_SPACE;
			_query += "PK_" + tabela.descricao.toUpperCase();
			_query += BLANK_SPACE;
			_query += createHighlight(PRIMARY_KEY, _highlight);
			_query += BLANK_SPACE;
			_query += ABRE_PARENTESE;
			
			for each (var campo:CampoDTO in tabela.campos)
			{
				if (campo.chavePrimaria)
				{
					_query += campo.descricao;
				}
			}
			
			_query += FECHA_PARENTESE;
			_query += CARRIAGE_RETURN;
		}
	
		private function createEndTable():void
		{
			_query += FECHA_PARENTESE;
			_query += PONTO_VIRGULA;
			_query += CARRIAGE_RETURN + CARRIAGE_RETURN;
		}
		
		private function createForeingKeys(mer:MerDTO):void
		{
			for each (var tabela:TabelaDTO in mer.tabelas)
			{
				for each (var campo:CampoDTO in tabela.campos)
				{
					if (campo.tabelaEstrangeira)
					{
						_query += createHighlight(ALTER_TABLE, _highlight);
						_query += BLANK_SPACE;
						_query += tabela.descricao;
						_query += CARRIAGE_RETURN;
						_query += createHighlight(ADD_CONSTRAINT, _highlight);
						_query += BLANK_SPACE;
						_query += "FK_" + tabela.descricao + "_PK_" + campo.tabelaEstrangeira.descricao + " FOREIGN KEY (";
						
						for each (var campoEstrangeira:CampoDTO in campo.tabelaEstrangeira.campos)
						{
							if (campoEstrangeira.chavePrimaria)
							{
								_query += campoEstrangeira.descricao;
							}
							_query += FECHA_PARENTESE;
						}
						
						_query += CARRIAGE_RETURN;
						_query += createHighlight(REFERENCES, _highlight);
						_query += BLANK_SPACE;
						_query += campo.tabelaEstrangeira.descricao;
						_query += BLANK_SPACE;
						_query += ABRE_PARENTESE;
						
						for each (var campoEstrangeira2:CampoDTO in campo.tabelaEstrangeira.campos)
						{
							if (campoEstrangeira2.chavePrimaria)
							{
								_query += campoEstrangeira2.descricao;
							}
							
							_query += FECHA_PARENTESE;
						}
						
						_query += CARRIAGE_RETURN;
						_query += createHighlight(DEFAULT_CONSTRAINT, _highlight);
					}
				}
			}
		}
		
		/*  alter table ARQUIVO
   			add constraint FK_ARQUIVO_PK_PASTA__PASTA foreign key (ID_PASTA)
      		references PASTA (ID_PASTA)
      		on delete restrict on update restrict;
      	*/
      	
      	private function novaData():String
		{
			var formatDate:DateFormatter = new DateFormatter();
			formatDate.formatString = "DD/MM/YYYY";
			return formatDate.format(new Date());
		}
		
		private function createHighlight(str:String, highlight:Boolean):String
		{
			if (highlight) {
				return "<b>" + str + "</b>";
			} else {
				return str;
			}
		}
		
		public function parserScript(mer:MerDTO, highlight:Boolean = false):String
		{
			
			if (mer != null && mer.tabelas != null && mer.tabelas.length > 0)
			{
				_highlight = highlight;
				
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
				
				createForeingKeys(mer);
			}
			
			return _query;
		}
		
	}
}