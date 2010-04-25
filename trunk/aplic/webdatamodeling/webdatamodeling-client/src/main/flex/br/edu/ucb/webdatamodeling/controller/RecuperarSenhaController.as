package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.RecuperarSenha;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.other.pfp.rsscube.models.MainModel;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import mx.controls.Alert;
	
	public class RecuperarSenhaController extends AbstractController
	{
		[Bindable]
      	private var _model:MainModel = MainModel.GetInstance();
      	
		private var _view:RecuperarSenha;
		
		private var _usuarioDTO:UsuarioDTO;
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		public function RecuperarSenhaController(view:RecuperarSenha)
		{
			_view = view;
			_usuarioDTO = new UsuarioDTO();
		}
		
		public function get model():MainModel
		{
			return _model;
		}
		
		public function recuperarSenha():void
		{
			_usuarioDTO.email = _view.txtEmail.text;
			
			_usuarioService.recuperarSenha(_usuarioDTO);
			_usuarioService.addEventListener("recuperarSenha", posRecuperarSenha);
		}
		
		private function posRecuperarSenha(event:CustomEvent):void
		{
			var usuarioDTORetorno:UsuarioDTO;
			
			if (event.data != null) {
				usuarioDTORetorno = event.data as UsuarioDTO;
				
				if (usuarioDTORetorno.erro == false) {
					Alert.show("A senha foi enviada para o seu e-mail.", "Envio de e-mail");
				} else {
					Alert.show(usuarioDTORetorno.mensagemErro, "Erro durante o envio de e-mail");
				}
			}
		}
		
	}
}