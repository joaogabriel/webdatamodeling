package br.edu.ucb.webdatamodeling.dto
{
	public class AbstractDTO
	{
		private var _erro:Boolean;
		private var _mensagemErro:String;

		public function get erro():Boolean
		{
			return _erro;
		}
		
		public function set erro(erro:Boolean):void
		{
			_erro = erro;
		}
		
		public function get mensagemErro():String
		{
			return _mensagemErro;
		}
		
		public function set mensagemErro(mensagemErro:String):void
		{
			_mensagemErro = mensagemErro;
		}
	}
}