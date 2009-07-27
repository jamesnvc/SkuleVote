function vote_system(){
	//fakes console.log when firebug isn't on
	if(typeof console === "undefined"){
		console = { log: function() { } };
	}
	
	if($('start')){
		var state = 1;
		
		$('submit').observe('click', function(e){
			var i = 0
			Sortable.sequence('end').each(function(e){
				//console.log(e);
				$('vote_'+e+'_result').value = ++i;	
			});
		});
		
		Sortable.create('start',{
			constraint:false,
			dropOnEmpty:true,
			hoverclass: 'onDrag',
			containment:['start','end']
		});
		Sortable.create('end', {
			containment:['start','end'],
			hoverclass: 'onDrag',
			dropOnEmpty:true,
		
			onUpdate:function(element){
				
				/* System can be 3 states:
					1: Start Full, End Empty
					2: Transition
					3: Start Empty, End Full
				
				
				*/
				
				if(state == 2){ //LEAVING STATE 2
					if(Sortable.sequence('start').length == 0){ //GOING INTO STATE 3
						//disable message in end
						$('end').addClassName('noMessage');
					
						//set state to 3
						state = 3;
					
						console.log('Entered State 3: Start Empty, End Full');
					} else 
					if(Sortable.sequence('end').length == 0){ //GOING INTO STATE 1			
						//disable message in start
						$('start').addClassName('noMessage');
					
						//disable submit
						$('submit').addClassName('disabled').disable();
					
						//set state to 1
						state = 1;
					
						console.log('Entered State 1: Start Full, End Empty');
					}
				} else if(Sortable.sequence('start').length != 0) { // GOING INTO STATE 2
					//enable message in start
					$('start').removeClassName('noMessage');
					
					//enable message in end
					$('end').removeClassName('noMessage');
								
					//enable submit button
					$('submit').removeClassName('disabled').enable();
					
					//set state to 2
					state = 2;
					
					console.log('Entered State 2: Transition');
				} else { 
					console.log('logic error');
				} 
				console.log(Sortable.sequence('end').join(", "));
			}		
		});
	} 
	else {
		$$('.radio').each(function(e){
			e.observe('click', function(){
				$('submit').removeClassName('disabled').enable();
				//TO-DO: add "remove this observer"
			});
		});
	}
}
