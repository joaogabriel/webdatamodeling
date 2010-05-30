package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.messaging.ChannelSet;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class TipoCampoService extends EventDispatcher
	{
		private var _remoteObject:RemoteObject;
        private static var _instance:TipoCampoService;
        
		public function TipoCampoService()
		{
			super();
            _remoteObject = new RemoteObject();
            _remoteObject.showBusyCursor = true;
            _remoteObject.destination = "TipoCampoService";
            _remoteObject.channelSet = new ChannelSet(['webdatamodeling-amf']);
            _remoteObject.showBusyCursor = false;
            return;
		}
        
        public function findAll():void
        {
        	_remoteObject.addEventListener("result", findAllHandler);
        	_remoteObject.findAll();
        }
        
        private function findAllHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("findAll", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, findAllHandler);
        }
        
        public static function getInstance():TipoCampoService
        {
            if (_instance == null) 
            {
                _instance = new TipoCampoService();
            }
            return _instance;
        }

	}
}