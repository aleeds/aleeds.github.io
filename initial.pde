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

var drawCirc = function() {
    for (var x = 350;x < 450;x = x + 2) {
        var y = sqrt(50*50 - (x - 400) * (x - 400)) + 400;
        stroke(255,0,0);
        circ(x,y,5);
        y = -1*sqrt(50*50 - (x - 400) * (x - 400)) + 400;
        circ(x,y,5);
    }

}

var w = width;
var h = height;
var cX = w/2;
var cY = h/2;

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
var weight =.1;
var bigDraw = function(which) {
    for (var i = width/2; i <= width ;i = i + seps) {
      for (var q = height/2; q <= height ; q = q + seps) {
        circ(i,q,1);
        strokeWeight(weight);
        line(i, q,i+seps,q);
        line(i, q,i-seps,q);
        line(i, q,i,q + seps);
        line(i, q,i,q - seps);
        strokeWeight(1);
      }
      for (var q = height/2; q >= 0 ; q = q - seps) {
        circ(i,q,1);
        strokeWeight(weight);
        line(i, q,i+seps,q);
        line(i, q,i-seps,q);
        line(i, q,i,q + seps);
        line(i, q,i,q - seps);
        strokeWeight(1);
      }
    }
    for (var i = width/2; i >= 0 ;i = i - seps) {
      for (var q = height/2; q <= height ; q = q + seps) {
        circ(i,q,1);
        strokeWeight(weight);
        line(i, q,i+seps,q);
        line(i, q,i-seps,q);
        line(i, q,i,q + seps);
        line(i, q,i,q - seps);
        strokeWeight(1);
      }
      for (var q = height/2; q >= 0 ; q = q - seps) {
        circ(i,q,1);
        strokeWeight(weight);
        line(i, q,i+seps,q);
        line(i, q,i-seps,q);
        line(i, q,i,q + seps);
        line(i, q,i,q - seps);
        strokeWeight(1);
      }
    }
};

drawCirc();
stroke(0,0,0);
rectMode(CENTER);
rectMode(RADIUS);
translate(width/2,height/2);
rotate(PI/4);
rect(0,0,seps * sqrt(2),seps * sqrt(2));
rotate(-PI/4);
translate(-width/2,-height/2);
bigDraw();
line(width/2,0,width/2,height);
line(0,height/2,width,height/2);






