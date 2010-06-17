package br.edu.ucb.webdatamodeling.dto
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.TipoCampoDTO")]
	public class TipoCampoDTO extends AbstractDTO
	{
		
		private var _id:Number;
		private var _descricao:String;
		private var _valorMinimo:Number;
		private var _valorMaximo:Number;
		private var _campos:ArrayCollection;
		
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

		public function get campos():ArrayCollection
		{
			return _campos;
		}
		
		public function set campos(value:ArrayCollection):void 
		{
			_campos = value;
		}
		
	}
}