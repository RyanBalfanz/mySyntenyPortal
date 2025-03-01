var contextMargin = {top: 190, right: 40, bottom: 225, left: 150},
contextWidth = 800 - contextMargin.left - contextMargin.right,
contextHeight = 440 - contextMargin.top - contextMargin.bottom;
var genomeSize;

function linearBrush(layout, callbackObj) {
    this.layout;
    this.callbackObj = callbackObj;
    genomeSize = layout.genomesize;
    
    this.brushContainer = d3.select(layout.container);
	//console.log(this.brushContainer);
    this.x1 = d3.scale.linear()
			.range([0,contextWidth])
    	   	.domain([0, layout.genomesize]);

    this.mini = this.brushContainer.append("g")
			.attr("transform", "translate(" + contextMargin.left + "," + contextMargin.top + ")")
			.attr("width", contextWidth)
			.attr("height", contextHeight)
			.attr("class", "miniBrush");

	
    this.brush = d3.svg.brush()
			.x(this.x1)
			.on("brush", this.brushUpdate.bind(this));
    //this.brush = brush;

    //console.log(this.brush);
    this.brushContainer = this.mini.append("g")
			.attr("class", "track brush")
			.call(this.brush.bind(this))
			.selectAll("rect")
			.attr("y", 1)
			.attr("height", contextHeight - 1);		
							
    this.axisContainer = this.mini.append("g")
			.attr('class', 'brushAxis')
			.attr("transform", "translate(" + 0 + "," + contextHeight + ")");

    this.xAxis = d3.svg.axis().scale(this.x1).orient("bottom")
			.tickFormat(d3.format("s"));

    this.axisContainer.append("g")
		    .attr("class", "context axis bottom")
		    .attr("transform", "translate(0," + 0 + ")")
    		.call(this.xAxis);
	
	d3.selectAll(".tick")
			.style("font","12px arial");

}

linearBrush.prototype.brushUpdate = function(b) {
    var minExtent = this.brush.extent()[0];
    var maxExtent = this.brush.extent()[1];
    
    if (minExtent < 0 || maxExtent < 0)
    {
    	if (minExtent < 0)
    	{
    		minExtent = 0;
    	}
    	else
    	{
    		minExtent = 0;
    		maxExtent = 1000000;
    	}    
    	var rangeExtent = [this.x1(minExtent),this.x1(maxExtent)];
    	var rangeWidth = rangeExtent[1] - rangeExtent[0];
    	d3.select("rect.extent").attr("width",rangeWidth);
    }
    	
    if ((maxExtent - minExtent) <= 1000)
    {
    	//alert("Brush does not function");
    	if (minExtent + 1000000 > genomeSize)
    	{
    		maxExtent = genomeSize;
    	}
    	else
    	{
    		maxExtent = minExtent + 1000000
    	}
    	var rangeWidth = this.x1(maxExtent) - this.x1(minExtent);
    	d3.select("rect.extent").attr("width",rangeWidth);
    }
    
    if( Object.prototype.toString.call( this.callbackObj ) === '[object Array]' ) 
    {
    	for(var obj in this.callbackObj) 
    	{
    		if(this.callbackObj.hasOwnProperty(obj))
    		{
    			this.callbackObj[obj].update(minExtent, maxExtent);
    	    }
    	}
    } 
    else 
    {
        this.callbackObj.update(minExtent, maxExtent);
    }
}

linearBrush.prototype.update = function(startBP, endBP) {
	
	//console.log(startBP,endBP);
	this.brush.extent([startBP, endBP]);
	
	//d3.select('.track brush').call(this.brush);
	d3.selectAll('.brush').call(this.brush);
	this.brush;
}

linearBrush.prototype.update_finished = function(startBP, endBP) {

}

linearBrush.prototype.addBrushCallback = function(obj) {

    // We allow multiple brushes to be associated with a linear plot, if we have
    // a brush already, add this new one on.  Otherwise just remember it.

    if('undefined' !== typeof this.callbackObj) {

	if( Object.prototype.toString.call( obj ) === '[object Array]' ) { 
	    this.callbackObj.push(obj);
	} else {
	    var tmpobj = this.callbackObj;
	    this.callbackObj = [tmpobj, obj];
	}
    } else {
	this.callbackObj = obj;
    }

}
