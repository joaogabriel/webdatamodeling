package br.edu.ucb.webdatamodeling.script
{
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
	
	import mx.collections.ArrayCollection;
	
	public class ParseScript
	{
		// constantes de string comuns
		private static const BLANK_SPACE:String = " ";
		private static const TAB_SPACE:String = "	";
		private static const ABRE_PARENTESE:String = "(";
		private static const FECHA_PARENTESE:String = ")";
		private static const PONTO_VIRGULA:String = ";";
		private static const CARRIAGE_RETURN:String = "\n";
		private static const CREATE_TABLE:String = "CREATE TABLE";
		
		// objeto �nico da classe
		private static var _instance:ParseScript;
		
		private var _query:String;
			
		public function ParseScript()
		{
			_query = new String();
		}
		
		public static function get instance():ParseScript {
			if (_instance == null) {
				_instance = new ParseScript();
			}
			return _instance;
		}

		private function createTabela(tabela:TabelaDTO):void {
			_query += CREATE_TABLE;
			_query += BLANK_SPACE;
			_query += tabela.descricao;
			_query += BLANK_SPACE;
			_query += ABRE_PARENTESE;
			_query += CARRIAGE_RETURN;
		}
	
		private function createCampos(tabela:TabelaDTO):void {
			for each(var campo:CampoDTO in tabela.campos) {
				_query += TAB_SPACE;
				_query += campo.descricao;
				_query += BLANK_SPACE;
				//_query += campo.tipo.descricao;
				_query += "INTEGER";
				_query += BLANK_SPACE;
				_query += ABRE_PARENTESE;
				_query += campo.tamanho;
				_query += FECHA_PARENTESE;
				_query += PONTO_VIRGULA;
				_query += CARRIAGE_RETURN;
			}
		}
	
		private function createEndTable():void {
			_query += FECHA_PARENTESE;
			_query += PONTO_VIRGULA;
		}
		
		public function parserScript(tabelas:ArrayCollection):String {
			for each (var tabela:TabelaDTO in tabelas) {
				createTabela(tabela);
				createCampos(tabela);
				createEndTable();
			}
			return _query;
		}
		
	}
}