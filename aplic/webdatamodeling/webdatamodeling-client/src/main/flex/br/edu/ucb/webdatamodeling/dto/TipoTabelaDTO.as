package br.edu.ucb.webdatamodeling.dto
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.TipoTabelaDTO")]
	public class TipoTabelaDTO extends AbstractDTO
	{
		
		private var _id:Number;
		private var _descricao:String;
		private var _tabelas:ArrayCollection;
		
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

		public function get tabelas():ArrayCollection
		{
			return _tabelas;
		}
		
		public function set tabelas(value:ArrayCollection):void 
		{
			_tabelas = value;
		}


	}
}