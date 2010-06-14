package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.Login;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.validators.Validator;
	
	import pfp.rsscube.models.MainModel;
	
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
		
	
		public function validarLogin():void
		{
			if ( Validator.validateAll([_view.valEmail,_view.valSenha]).length == 0 )
				login();
			else
				Alert.show(_resourceManager.getString('messages', 'usuarioConrtoler.msg_1'));
		}
		
		public function login():void
		{
			_view.btnLogin.enabled = false;
			_view.btnLogin.label = _resourceManager.getString('messages', 'usuario.msgAutenticando');
			
			_usuarioDTO.email = _view.txtEmail.text;
			_usuarioDTO.senha = _view.txtSenha.text;
			
			_usuarioService.addEventListener("login", habilitarBotaoLogin);
			_usuarioService.efetuarLogin(_usuarioDTO);
		}
		
		private function habilitarBotaoLogin(event:CustomEvent):void
		{
			if (event.data == null)
			{
				var str:String = _resourceManager.getString('messages', 'usuarioConrtoler.msg_2');
				Alert.show(str);
				_view.btnLogin.enabled = true;
				_view.btnLogin.label = 'Login';
			}
		}

	}
}