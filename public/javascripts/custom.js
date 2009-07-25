function sortables(){

	Sortable.create('start',{
		ghosting:true, 
		constraint:false, 
		containment:['end'],

		onChange:function(element){
			/*
			// Total elements in the list (in this case 7 <li> element)
			var totElement = 7;
			var newOrder = Sortable.serialize(element.parentNode);
			for(i=1; i<=totElement; i++){
				newOrder = newOrder.replace("myList[]=","");
				newOrder = newOrder.replace("&",",");
			}
			// display the string with the new order in the &ltPgt; with id listNewOrder
			$('listNewOrder').innerHTML = 'New Order: ' + newOrder;
		*/
		}
	});
	Sortable.create('end', {
		containment:['start','end'],
		dropOnEmpty:true,
		
		onUpdate:function(element){
			console.log('updated!');
			var order = Sortable.serialize('end');
			
			order = order.replace(/end\[\]=/g,"");
			order = order.replace(/&/g,",");
	
			console.log(order);
		}
	});
}
