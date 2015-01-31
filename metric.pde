void setup() {
    size(800,800);
}

ellipseMode(CENTER);
var circ = function(x,y,r) {
    ellipse(x,y,r,r);
};

var seps = 15;



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

var dist1 = function(xone,yone,xtwo,ytwo) {
    var distX = xone - xtwo;
    var distY = yone - ytwo;
    return abs(distX) + abs(distY);
    
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
    var tPUpper = new PVector(po.x,po.y);
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

var bigDraw = function(which) {
    for (var i = 0; i < width;i = i + seps) {
    for (var q = 0; q < height ;q = q + seps) {
        if (which === 0) {
            var xy = new PVector(i,q);
            stroke(0,0,0);
            circ(i,q,0.5);
            var eD = eDistC(i,q);
            var newXy = deform(xy,eD);
            stroke(255, 0, 0);
            circ(newXy.x,newXy.y,0.5);
        }  else if(which === 1) {
            var xy = new PVector(i,q);
           // circ(i,q,1);
            var eD = eDistC(i,q);
            var newXy = deform(xy,eD);
            stroke(255, 0, 0);
            circ(newXy.x,newXy.y,1);
        } else {
            var xy = new PVector(i,q);
           // circ(i,q,1);
            var eD = eDistC(i,q);
            var newXy = deform(xy,eD);
            strokeWeight(0.1);
            stroke(191, 74, 191);
            //circ(newXy.x,newXy.y,1);
            line(xy.x,xy.y,newXy.x,newXy.y);
            circ(newXy.x,newXy.y,0.05);
        }
    }
}
};


bigDraw();



