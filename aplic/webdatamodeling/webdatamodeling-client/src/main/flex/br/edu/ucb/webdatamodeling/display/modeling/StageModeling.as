package br.edu.ucb.webdatamodeling.display.modeling {
	import flash.utils.setTimeout;
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
	import br.edu.ucb.webdatamodeling.events.ModelingEvent;
	import flash.net.URLRequest;

	import ru.etcs.utils.FontLoader;

	import br.edu.ucb.webdatamodeling.display.modeling.events.MenuEvent;
	import br.edu.ucb.webdatamodeling.display.modeling.menu.StageMenu;

	import flash.system.SecurityDomain;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	import br.com.stimuli.loading.BulkLoader;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	public class StageModeling extends Sprite 
	{
		static private var _isDrawingRelationship : Boolean;
		private var _fontLoader : FontLoader;

		static public function get isDrawingRelationship() : Boolean {return _isDrawingRelationship;}
		
		
		private var _bg:Shape;
		private var _bulk:BulkLoader;
		private var _menu:StageMenu;
		private var _tables:Array;
		private var _notes:Array;
		private var _relationships:Array;
		
		public function get data():Array
		{
			var r:Array = [];
			for(var i:uint = 0; i<_tables.length; i++)
				r[i] = TableView(_tables[i]).generateData();
			
			return r;
		}

		public function StageModeling()
		{
			_tables = [];
			_notes = [];
			_relationships = [];
			_bg = new Shape();
			_bg.graphics.lineStyle(1, 0xCCCCCC);
			for(var i:uint = 0; i < 300; i++)
			{
				_bg.graphics.moveTo(i * 10, 0);
				_bg.graphics.lineTo(i * 10, 1000);
			}
			for(i = 0; i < 1000; i++)
			{
				_bg.graphics.moveTo(0, i * 10);
				_bg.graphics.lineTo(2000, i * 10);
			}
			addChild( _bg );
			load();
			addEventListener(MenuEvent.SELECT_CREATE_TABLE, createTableHandler);
			addEventListener(MenuEvent.SELECT_SAVE, selectSaveHandler);
			addEventListener(MenuEvent.SELECT_GENERETE_NOTE, selectNoteHandler);
			addEventListener(MenuEvent.SELECT_CLEAR, selectClearHandler);
		}

		public function openMer( tables:Array ):void
		{
			var len:uint = tables.length;
			
			for(var i:uint=0; i<len; i++)
				setTimeout(createTable, i*70, TabelaDTO(tables[i]));
				
			setTimeout(createRelationShips, i*70);
		}
		
		public function loadFieldTypes( types:Array ):void
		{
			TableAttribute.types = types;
		}
		
		public function loadTableTypes( types:Array ):void
		{
			TableView.tableTypes = types;
		}
		
		public function kill():void
		{
			clear();
			removeEventListener(MenuEvent.SELECT_CREATE_TABLE, createTableHandler);
			removeEventListener(MenuEvent.SELECT_SAVE, selectSaveHandler);
			removeEventListener(MenuEvent.SELECT_GENERETE_NOTE, selectNoteHandler);
			removeEventListener(MenuEvent.SELECT_CLEAR, selectClearHandler);
			
			stage.removeEventListener(MouseEvent.CLICK, clickStageHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, clickToStopDrawingHandler);
			
			parent.removeChild(this);
		}

		private function createTable( tableDTO:TabelaDTO ):void
		{
			var lenCampos:uint;
			var table:TableView;
			var attribute:TableAttribute;
			
			table = new TableView(tableDTO.descricao);
			table.x = tableDTO.coordenadaX;
			table.y = tableDTO.coordenadaY;
			_tables.push(table);
			table.addEventListener(TableView.START_RELATIONSHIP, startRelationshipHandler);
			lenCampos = tableDTO.campos.length;
			
			for(var j:uint=0; j<lenCampos; j++)
			{
				if(CampoDTO(tableDTO.campos[j]).tabelaEstrangeira) 
				{
					_relationships.push({table:table, dto:CampoDTO(tableDTO.campos[j]).tabelaEstrangeira});
					continue;
				}
				attribute = new TableAttribute(CampoDTO(tableDTO.campos[j]).descricao, 
				CampoDTO(tableDTO.campos[j]).tipo.id,
				false, 
				CampoDTO(tableDTO.campos[j]).chavePrimaria) ;
				
				table.addAttribute(attribute);
				addChild(table);
			}
			table.addEventListener(TableView.KILL, killTableHandler);
		}

		private function createRelationShips() : void 
		{
			var len:uint = _relationships.length;
			var lenAtt:uint;
			var att:TableAttribute;
			
			for(var i:uint=0; i<len; i++)
				addChildAt(new RelationshipView(TableView( _relationships[i].table ), RelationshipView.TYPE_N_1, getTableByName(_relationships[i].dto.descricao)), 1);
		}
		
		private function getTableByName(name:String):TableView
		{
			var len:uint = _tables.length;
			
			for(var i:uint=0; i<len; i++)
				if(TableView(_tables[i]).title == name)
					return TableView(_tables[i]);
					
			return null;
		}

		private function load() : void 
		{
			_bulk = new BulkLoader("main");
			_bulk.add("assets/swf/library.swf", { id:"library", context:new LoaderContext( false, ApplicationDomain.currentDomain ) } );
			_bulk.add("assets/swf/fonts.swf", { id:"fonts", context:new LoaderContext( false, ApplicationDomain.currentDomain ) } );
			_bulk.addEventListener(Event.COMPLETE, loadHandler);
			_bulk.start();
		}

		private function showMenu() : void 
		{
			_menu.x = mouseX;
			_menu.y = mouseY;
			addChild(_menu);
			_menu.show();
		}
		
		private function clear():void
		{
			var len:uint = _tables.length;
			
			for(var i:uint=0; i<len; i++)
			{
				_tables[0].addEventListener(TableView.START_RELATIONSHIP, startRelationshipHandler);
				_tables[0].kill();
			}
		}
		

		private function selectClearHandler(event : MenuEvent) : void 
		{
			clear();
		}

		private function selectSaveHandler(event : MenuEvent) : void 
		{
			dispatchEvent(new ModelingEvent(ModelingEvent.SAVE, data));
		}
		
		private function selectNoteHandler(event : MenuEvent) : void 
		{
			var note:NoteView = new NoteView();
			note.x = event.target.parent.x;
			note.y = event.target.parent.y;
			addChild(note);
			_notes.push( note );
			note.addEventListener(Event.REMOVED_FROM_STAGE, removeNoteFromStage);
		}

		private function removeNoteFromStage(event : Event) : void 
		{
			event.target.removeEventListener(Event.REMOVED_FROM_STAGE, removeNoteFromStage);
			_notes.splice(_notes.indexOf(event.target), 1);
		}

		private function createTableHandler(event : MenuEvent) : void 
		{
			var table:TableView = new TableView();
			table.x = event.target.parent.x;
			table.y = event.target.parent.y;
			_tables.push(table);
			table.addEventListener(TableView.START_RELATIONSHIP, startRelationshipHandler);
			addChild(table);
			event.stopPropagation();
			table.addEventListener(TableView.KILL, killTableHandler);
		}

		private function killTableHandler(event : Event) : void 
		{
			event.target.removeEventListener(TableView.KILL, killTableHandler);
			_tables.splice(_tables.indexOf(event.target), 1);
		}

		private function loadHandler(event : Event) : void 
		{
			_fontLoader = new FontLoader();
			_fontLoader.addEventListener( Event.COMPLETE, loadFontHandler );
			_fontLoader.load( new URLRequest("assets/swf/fonts.swf") );
		}

		private function loadFontHandler(event : Event) : void 
		{
			trace(_fontLoader.fonts);
			_menu = new StageMenu();
			stage.addEventListener(MouseEvent.CLICK, clickStageHandler);
			dispatchEvent( new Event(Event.COMPLETE) );
		}

		private function startRelationshipHandler(event : MenuEvent) : void 
		{
			var relationship:RelationshipView = new RelationshipView(TableView( event.target ), event.data);
			relationship.addEventListener(RelationshipView.TYPE_N_N, relationNNHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, clickToStopDrawingHandler);
			addChildAt(relationship, 1);
			_isDrawingRelationship = true;
		}

		private function relationNNHandler(event : Event) : void 
		{
			var table:TableView = new TableView(event.target.point1.title+"_"+event.target.point2.title);
			//table.addAttribute(new TableAttribute("id", undefined, false, true, false, null,false,true));
			table.x = event.target.point1.x + (event.target.point2.x - event.target.point1.x)/2;
			table.y = event.target.point1.y + (event.target.point2.y - event.target.point1.y)/2;
			_tables.push(table);
			
			table.addEventListener(TableView.START_RELATIONSHIP, startRelationshipHandler);
			addChild(table);
			addChildAt(new RelationshipView(table, RelationshipView.TYPE_N_1, event.target.point1), 1);
			addChildAt(new RelationshipView(table, RelationshipView.TYPE_N_1, event.target.point2), 1);
			
			for(var i:uint = 0; i<table.attributes.length; i++)
				table.attributes[i].isPK = true;
		}

		private function clickToStopDrawingHandler(event : MouseEvent) : void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, clickToStopDrawingHandler);
			_isDrawingRelationship = false;
		}

		private function clickStageHandler(event : MouseEvent) : void 
		{
			showMenu();
		}
	}
}
