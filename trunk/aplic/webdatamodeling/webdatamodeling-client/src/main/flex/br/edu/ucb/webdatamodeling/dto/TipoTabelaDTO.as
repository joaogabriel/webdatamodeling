package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.TipoTabelaDTO")]
	public class TipoTabelaDTO
	{
		
		private var _id:Number;
		private var _descricao:String;
		private var _tabelas:Array;
		
		public function TipoTabelaDTO()
		{
		}
		
		public function get id():Number
		{
			return _id;
		}
		
		public function set id(value:Number):void 
		{
			_id = value;
		}
		
		public function get descricao():String
		{
			return _descricao;
		}
		
		public function set descricao(value:String):void 
		{
			_descricao = value;
		}

		public function get tabelas():Array
		{
			return _tabelas;
		}
		
		public function set tabelas(value:Array):void 
		{
			_tabelas = value;
		}


	}
}