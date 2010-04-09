package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.TipoCampoDTO")]
	public class TipoCampoDTO
	{
		
		private var _id:Number;
		private var _descricao:String;
		private var _valorMinimo:Number;
		private var _valorMaximo:Number;
		private var _campos:Array;
		
		public function TipoCampoDTO()
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
		
		public function get valorMinimo():Number
		{
			return _valorMinimo;
		}
		
		public function set valorMinimo(value:Number):void 
		{
			_valorMinimo = value;
		}
		
		public function get valorMaximo():Number
		{
			return _valorMaximo;
		}
		
		public function set valorMaximo(value:Number):void 
		{
			_valorMaximo = value;
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