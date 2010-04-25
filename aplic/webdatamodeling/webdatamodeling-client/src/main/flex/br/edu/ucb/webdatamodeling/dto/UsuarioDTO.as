package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.UsuarioDTO")]
	public class UsuarioDTO extends AbstractDTO
	{
		private var _id:Number;
		private var _nome:String;
		private var _sobrenome:String;
		private var _email:String;
		private var _senha:String;
		private var _dataCadastro:Date;
		private var _dataNascimento:Date;
		
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
		
		public function get nome():String
		{
			return _nome;
		}
		
		public function set nome(value:String):void 
		{
			_nome = value;
		}
		
		public function get sobrenome():String
		{
			return _sobrenome;
		}
		
		public function set sobrenome(value:String):void 
		{
			_sobrenome = value;
		}
		
		public function get email():String
		{
			return _email;
		}
		
		public function set email(value:String):void 
		{
			_email = value;
		}
		
		public function get senha():String
		{
			return _senha;
		}
		
		public function set senha(value:String):void 
		{
			_senha = value;
		}
		
		public function get dataCadastro():Date
		{
			return _dataCadastro;
		}
		
		public function set dataCadastro(value:Date):void 
		{
			_dataCadastro = value;
		}
		
		public function get dataNascimento():Date
		{
			return _dataNascimento;
		}
		
		public function set dataNascimento(value:Date):void 
		{
			_dataNascimento = value;
		}

	}
}