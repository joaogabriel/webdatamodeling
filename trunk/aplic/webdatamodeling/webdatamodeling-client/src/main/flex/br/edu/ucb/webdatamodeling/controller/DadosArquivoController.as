package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.CompartilharMER;
	import br.edu.ucb.webdatamodeling.components.DadosArquivo;
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.service.ArquivoService;
	
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	public class DadosArquivoController
	{
		private var _view:DadosArquivo;
		private var _arquivo:ArquivoDTO;
		private var _arquivoService:ArquivoService = ArquivoService.getInstance();
		
		public function DadosArquivoController(view:DadosArquivo, arquivo:ArquivoDTO)
		{
			_view = view;
			_arquivo = arquivo;
			
			setDadosArquivo();
		}
		
		private function setDadosArquivo():void
		{
			_view.nome.text = _arquivo.nome;
			//_view.dtCriacao.text = _arquivo.dataCriacao;
			//_view.dtUltimaAlteracao.text = _arquivo.dataUltimaAlteracao;
			_view.descricao.text = _arquivo.descricao;
			_view.versao.value = _arquivo.versao as Number;
		}
		
		public function salvar():void
		{
			
		}
		
		public function showModelagem():void
		{
			/* var ui:UIComponent = new UIComponent();
			_modeling = new StageModeling();
			ui.addChild(_modeling);
			_view.content.addChild(ui);
            _modeling.addEventListener(Event.COMPLETE, modelingCreatedHandler);
            _modeling.addEventListener(ModelingEvent.SAVE, modelingSaveHandler); */
		}
		
		public function exportar():void
		{
			Alert.show("Implementar!!!");
			
			var fileReference:FileReference = new FileReference();
			//fileReference.save(listaArquivos.selectedItem.byteArray, listaArquivos.selectedItem.nomeArquivo);
		}
		
		public function compartilhar():void
		{
			var popup:IFlexDisplayObject = PopUpManager.createPopUp(_view, CompartilharMER, true);
			PopUpManager.centerPopUp(popup);
		}
		
		public function excluir():void
		{
			Alert.show("Implementar!!!");
		}
	}
}