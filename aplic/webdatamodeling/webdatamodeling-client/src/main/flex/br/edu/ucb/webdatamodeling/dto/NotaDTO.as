package br.edu.ucb.webdatamodeling.dto
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.UsuarioDTO")]
	public class NotaDTO extends AbstractDTO
	{
		private var _id:Number;
		private var _descricao:String
		private var _mer:MerDTO;
		
		public function UsuarioDTO() 
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
		
		public function set descricao(descricao:String):void 
		{
			_descricao = descricao;
		}
		
		public function get mer():MerDTO
		{
			return _mer;
		}
		
		public function set mer(mer:MerDTO):void
		{
			_mer = mer;
		}
		
	}
}