package br.edu.ucb.webdatamodeling.dto
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.PastaDTO")]
	public class PastaDTO extends AbstractDTO
	{
		
		private var _id:Number;
		private var _nome:String;
		private var _descricao:String;
		private var _dataCriacao:Date;
		private var _dataUltimaAlteracao:Date;
		private var _usuario:UsuarioDTO;
		private var _arquivos:ArrayCollection;
		
		public function PastaDTO()
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
		
		public function get usuario():UsuarioDTO
		{
			return _usuario;
		}
		
		public function set usuario(value:UsuarioDTO):void 
		{
			_usuario = value;
		}
		
		public function get arquivos():ArrayCollection
		{
			return _arquivos;
		}
		
		public function set arquivos(value:ArrayCollection):void 
		{
			_arquivos = value;
		}

	}
}