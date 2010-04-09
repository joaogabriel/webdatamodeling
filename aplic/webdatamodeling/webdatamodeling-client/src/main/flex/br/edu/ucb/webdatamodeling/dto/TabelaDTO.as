package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.TabelaDTO")]
	public class TabelaDTO
	{
		
		private var _id:Number;
		private var _descricao:String;
		private var _comentario:String;
		private var _coordenadaX:Number;
		private var _coordenadaY:Number;
		private var _mer:Number;
		private var _tipo:Number;
		private var _campos:Array;
		
		public function TabelaDTO()
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
		
		public function get comentario():String
		{
			return _comentario;
		}
		
		public function set comentario(value:String):void 
		{
			_comentario = value;
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
		
		public function get mer():Number
		{
			return _mer;
		}
		
		public function set mer(value:Number):void 
		{
			_mer = value;
		}
		
		public function get tipo():Number
		{
			return _tipo;
		}
		
		public function set tipo(value:Number):void 
		{
			_tipo = value;
		}
		
		public function get campos():Array
		{
			return _campos;
		}
		
		public function set campos(value:Array):void 
		{
			_campos = value;
		}

	}
}