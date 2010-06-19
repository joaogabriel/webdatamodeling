package br.edu.ucb.webdatamodeling.dto
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.NotaDTO")]
	public class NotaDTO extends AbstractDTO
	{
		private var _id:Number;
		private var _descricao:String;
		private var _coordenadaX:Number;
		private var _coordenadaY:Number;
		private var _mer:MerDTO;
		
		public function NotaDTO() 
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
		
		public function get coordenadaX():Number
		{
			return _coordenadaX;
		}
		
		public function set coordenadaX(value:Number):void 
		{
			_coordenadaX = value;
		}
		
		public function get coordenadaY():Number
		{
			return _coordenadaY;
		}
		
		public function set coordenadaY(value:Number):void 
		{
			_coordenadaY = value;
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