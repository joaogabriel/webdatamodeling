package br.edu.ucb.webdatamodeling.service
{
	public class TipoTabelaService extends EventDispatcher
	{
		private var _remoteObject:RemoteObject;
        private static var _instance:TipoTabelaService;
		
		public function TipoTabelaService()
		{
			super();
            _remoteObject = new RemoteObject();
            _remoteObject.showBusyCursor = true;
            _remoteObject.destination = "TipoTabelaService";
            _remoteObject.channelSet = new ChannelSet(['webdatamodeling-amf']);
            _remoteObject.showBusyCursor = false;
            return;
		}

        public function findAll():void
        {
        	_remoteObject.addEventListener("result", findAllHandler);
        	_remoteObject.findAll();
        }
        
        public function findAllHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("findAll", event.result));
        }
        
        public static function getInstance():TipoTabelaService
        {
            if (_instance == null) 
            {
                _instance = new TipoTabelaService();
            }
            return _instance;
        }
        
	}
}