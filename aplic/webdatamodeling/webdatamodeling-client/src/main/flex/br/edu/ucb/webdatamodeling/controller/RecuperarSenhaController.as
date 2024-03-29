package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.RecuperarSenha;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import pfp.rsscube.models.MainModel;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.validators.Validator;
	
	public class RecuperarSenhaController extends AbstractController
	{
		[Bindable]
      	private var _model:MainModel = MainModel.GetInstance();
      	
		private var _view:RecuperarSenha;
		
		private var _usuarioDTO:UsuarioDTO;
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function RecuperarSenhaController(view:RecuperarSenha)
		{
			_view = view;
			_usuarioDTO = new UsuarioDTO();
		}
		
		public function get model():MainModel
		{
			return _model;
		}
		
		public function validarEsqueceu():void
		{
			if ( Validator.validateAll([_view.valEmail]).length == 0 )
				recuperarSenha();
			else
				Alert.show(_resourceManager.getString('messages', 'recuperarSenhaControler.preenchimentoIncorreto'));
		}
		
		public function recuperarSenha():void
		{
			_usuarioDTO.email = _view.txtEmail.text;
			
			_usuarioService.recuperarSenha(_usuarioDTO);
			_usuarioService.addEventListener("recuperarSenha", recuperarSenhaHandler);
		}
		
		private function recuperarSenhaHandler(event:CustomEvent):void
		{
			var usuarioDTORetorno:UsuarioDTO;
			
			if (event.data != null) 
			{
				usuarioDTORetorno = event.data as UsuarioDTO;
				
				if (usuarioDTORetorno.erro == false) 
				{
					Alert.show( _resourceManager.getString('messages', 'recuperar.campoObrigatorio'), _resourceManager.getString('messages', 'recuperar.campoObrigatorioComFormato') );
				} 
				else 
				{
					Alert.show(usuarioDTORetorno.mensagemErro, _resourceManager.getString('messages', 'recuperar.erroEnvio') );
				}
			}
		}
		
	}
}