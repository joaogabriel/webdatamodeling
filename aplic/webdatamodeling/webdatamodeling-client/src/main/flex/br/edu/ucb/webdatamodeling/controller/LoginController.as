package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.Login;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.other.pfp.rsscube.models.MainModel;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class LoginController
	{
		[Bindable]
		private var _usuarioDTO:UsuarioDTO = new UsuarioDTO();
		
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _view:Login;
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
			
		public function LoginController(view:Login)
		{
			_view = view;
		}
		
		public function get model():MainModel
		{
			return _model;
		}
		
		public function validaEmail():void
		{
			if ( _view.txtEmail.text == "" || _view.txtSenha.text == "" )
				Alert.show( _resourceManager.getString('messages', 'usuario.msgErro_2') );
			else
				Alert.show( _resourceManager.getString('messages', 'usuario.msgErro_3') );
		}
		
		public function validarLogin():void
		{
			if ( _view.txtEmail.text == "" || _view.txtSenha.text == "" )
			{
				Alert.show( _resourceManager.getString('messages', 'usuario.msgErro_1') );
			}
			else
			{
				login();
			}
			
		}
					
		public function login():void
		{
			_view.btnLogin.enabled = false;
			_view.btnLogin.label = _resourceManager.getString('messages', 'usuario.msgAutenticando');
			
			_usuarioDTO.email = _view.txtEmail.text;
			_usuarioDTO.senha = _view.txtSenha.text;
			
			_usuarioService.validarLogin(_usuarioDTO);
			
			_usuarioService.addEventListener("login", habilitarBotaoLogin);
		}
		
		private function habilitarBotaoLogin(event:CustomEvent):void
		{
			if (event.data == null) {
				Alert.show("O usuário informado não está cadastrado ou as informações preenchidas estão incorretas.");
				_view.btnLogin.enabled = true;
				_view.btnLogin.label = 'Login';
			}
		}

	}
}