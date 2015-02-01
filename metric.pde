
size(800,800);
background(250, 248, 239);
strokeWeight(2);
rect(0,0,width,height);
strokeWeight(1);
ellipseMode(CENTER);
var circ = function(x,y,r) {
    ellipse(x,y,r,r);
};

var seps = 20;



var w = width;
var h = height;
var cX = w/2;
var cY = h/2;
line(width/2,0,width/2,height);
line(0,height/2,width,height/2);
var eDist = function(xone,yone,xtwo,ytwo) {
   var distX = xone - xtwo;
   var distY = yone - ytwo;
   var distXSq = distX * distX;
   var distYSq = distY * distY;
   return sqrt(distYSq + distXSq);
};

var myMax = function(one,two) {
    if (one > two) return one;
    else return two;
}

var dist1 = function(xone,yone,xtwo,ytwo) {
    var distX = xone - xtwo;
    var distY = yone - ytwo;
    return abs(distX) + abs(distY);
    //return myMax(distX,distY);
    //return pow(pow(distX,3) + pow(distY,3),1/3);
};

var eDistC = function(x,y) {
    return eDist(x,y,cX,cY);
};

var dist1C = function(x,y) {
    return dist1(x,y,cX,cY);
};
var which = true;

var midPoint = function(one,two) {
  return new PVector((one.x + two.x)/2,(one.y + two.y)/2); 
};

var deform = function(po,eD) {
    var tPLower = new PVector(cX,cY);
    var tPUpper = new PVector(2*po.x -cX,2*po.y -cY);
    var tP = midPoint(tPUpper,tPLower);
    if (dist1C(po.x,po.y) === eD) {
        return po;
    } else {
         while(abs(dist1C(tP.x,tP.y) - eD) > 0.001) {
            if (dist1C(tP.x,tP.y) > eD) {
                var hold = tP;
                tP = midPoint(tPLower,tP);
                tPUpper = hold;
            } else {
                var hold = tP;
                tP = midPoint(tPUpper,tP);
                tPLower = hold;   
            }
        }
    }
    return tP;

};

var smallDraw = function(i,q) {
                var xy = new PVector(i,q);
                // circ(i,q,1);
                var eD = eDistC(i,q);
                var newXy = deform(xy,eD);
                var first = new PVector(i-seps,q-seps);
                var second = new PVector(i-seps,q+seps);
                var third = new PVector(i+seps,q-seps);
                var fourth = new PVector(i+seps,q+seps);
                var fst = deform(first,eDistC(first.x,first.y));
                var scd  = deform(second,eDistC(second.x,second.y));
                var thrd = deform(third,eDistC(third.x,third.y));
                var frth = deform(fourth,eDistC(fourth.x,fourth.y));
                strokeWeight(.2);
                strokeWeight(0,0,0);
                line(newXy.x,newXy.y,fst.x,fst.y);
                line(newXy.x,newXy.y,scd.x,scd.y);
                line(newXy.x,newXy.y,thrd.x,thrd.y);
                line(newXy.x,newXy.y,frth.x,frth.y);
                if (xy === newXy) {
                    circ(newXy.x,newXy.y,.3);
                
                } else {
                    strokeWeight(.1);
                    stroke(191, 74, 191);
                    //stroke(newXy.x,newXy.y,0);
                    //strokeWeight(eDist(newXy.x,newXy.y,xy.x,xy.y)/100);
                    line(xy.x,xy.y,newXy.x,newXy.y);
                
                    stroke(117,3,133);
                    strokeWeight(1);
                    circ(newXy.x,newXy.y,1);
                    
                }
}

var bigDraw = function(which) {
    for (var i = width/2; i <= width;i = i + seps) {
        for (var q = height/2; q <= height ;q = q + seps) {
                smallDraw(i,q);
            
        }
        for (var q = height/2; q >= 0 ;q = q - seps) {
            smallDraw(i,q);
            
        }
    } 
    for (var i = width/2; i >= 0;i = i - seps) {
        for (var q = height/2; q <= height ;q = q + seps) {
            smallDraw(i,q);
            
        }
        for (var q = height/2; q >= 0 ;q = q - seps) {
           smallDraw(i,q);
            
        }
    }
    

};


bigDraw();



