function vote_system(){
	//fakes console.log when firebug isn't on
	if(typeof console === "undefined"){
		console = { log: function() { } };
	}

	if($('start')){
		Sortable.create('start',{
			constraint:false
		});
		Sortable.create('end', {
			containment:['start','end'],
			hoverclass: 'onDrag',
			dropOnEmpty:true,
		
			onChange:function(element){
				if(Sortable.sequence('start').length == 0 && $('drop_message')) {
					//$('drop_message').innerHTML = 'REORDER?';
					$('drop_message').remove();
					$('end').setStyle({padding: 0});
					$('submit').removeClassName('disabled').enable();
				}	
			},
			onUpdate:function(element){
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
