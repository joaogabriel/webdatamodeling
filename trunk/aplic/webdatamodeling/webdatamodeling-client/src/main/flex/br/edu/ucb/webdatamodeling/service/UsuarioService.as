package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.messaging.ChannelSet;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class UsuarioService extends EventDispatcher
	{
		private var bridge:RemoteObject;
        private static var instance:UsuarioService;
        
		public function UsuarioService()
		{
			super();
            bridge = new RemoteObject();
            bridge.showBusyCursor = true;
            bridge.destination = "UsuarioService";
            bridge.channelSet = new ChannelSet(['webdatamodeling-amf']);
            bridge.showBusyCursor = false;
            return;
        }

        public function insert(usuario:UsuarioDTO):void
        {
        	bridge.addEventListener("result", insertHandler);
        	bridge.insert(usuario);
        }
        
        public function insertHandler(event:ResultEvent):void
        {
            var usuarioDTO:UsuarioDTO = event.result as UsuarioDTO;
            dispatchEvent(new CustomEvent("insert", usuarioDTO));
        }
        
        public function validarLogin(usuario:UsuarioDTO):void
        {
        	bridge.addEventListener("result", validarLoginHandler);
        	bridge.validarLogin(usuario);
        }
        
        public function validarLoginHandler(event:ResultEvent):void
        {                   
            var usuarioDTO:UsuarioDTO = event.result as UsuarioDTO;
            dispatchEvent(new CustomEvent("login", usuarioDTO));
        }

		// será que precisa?        
        private function defaultFaultHandler(e:FaultEvent):void
        {
            Alert.show(e.fault.faultDetail, e.fault.faultString);
            return;
        }

		// será que precisa?
        public static function getInstance():UsuarioService
        {
            if (instance == null) 
            {
                instance = new UsuarioService();
            }
            return instance;
        }

	}
}