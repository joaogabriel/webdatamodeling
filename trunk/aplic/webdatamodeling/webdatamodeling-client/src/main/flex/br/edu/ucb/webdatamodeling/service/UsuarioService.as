package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	
	import mx.controls.Alert;
	import mx.messaging.ChannelSet;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class UsuarioService extends Object
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
        	bridge.insert(usuario).addEventListener("result", insertHandler);
        }
        
        public function insertHandler(event:ResultEvent):UsuarioDTO
        {                   
            return event.result as UsuarioDTO
        }
        
        public function validarLogin(usuario:UsuarioDTO):void
        {
        	bridge.validarLogin(usuario).addEventListener("result", validarLoginHandler);
        }
        
        public function validarLoginHandler(event:ResultEvent):UsuarioDTO
        {                   
            return event.result as UsuarioDTO
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