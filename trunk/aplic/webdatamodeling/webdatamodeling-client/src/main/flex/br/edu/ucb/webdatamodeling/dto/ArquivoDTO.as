package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.ArquivoDTO")]
	public class ArquivoDTO
	{
		private var _id:Number;
		private var _versao:String;
		private var _nome:String;
		private var _descricao:String;
		private var _dataCriacao:Date;
		private var _dataUltimaAlteracao:Date;
		private var _pasta:Number;
		private var _tipo:Number;
		private var _mer:Number;
		
		public function ArquivoDTO()
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
		
		public function get versao():String
		{
			return _versao;
		}
		
		public function set versao(value:String):void 
		{
			_versao = value;
		}

		public function get nome():String
		{
			return _nome;
		}
		
		public function set nome(value:String):void 
		{
			_nome = value;
		}
		
		public function get descricao():String
		{
			return _descricao;
		}
		
		public function set descricao(value:String):void 
		{
			_descricao = value;
		}
		
		public function get dataCriacao():Date
		{
			return _dataCriacao;
		}
		
		public function set dataCriacao(value:Date):void 
		{
			_dataCriacao = value;
		}
		
		public function get dataUltimaAlteracao():Date
		{
			return _dataUltimaAlteracao;
		}
		
		public function set dataUltimaAlteracao(value:Date):void 
		{
			_dataUltimaAlteracao = value;
		}
		
		public function get pasta():Number
		{
			return _pasta;
		}
		
		public function set pasta(value:Number):void 
		{
			_pasta = value;
		}
		
		public function get tipo():Number
		{
			return _tipo;
		}
		
		public function set tipo(value:Number):void 
		{
			_tipo = value;
		}
		
		public function get mer():Number
		{
			return _mer;
		}
		
		public function set mer(value:Number):void 
		{
			_mer = value;
		}

	}
}