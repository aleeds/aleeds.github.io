var Team = (function() {
function Team() {
var $this_1 = this;
function $superCstr(){$p.extendClassChain($this_1)}
$this_1.score = 0;
$this_1.name = null;
$this_1.num = 0;
$this_1.theta = 0;
$this_1.x = 0;
$this_1.y = 0;
$this_1.img = null;
$this_1.msk = null;
$this_1.num_scores =  0;
$this_1.scores =  $p.createJavaArray('float', [1000]);
function AddScore$1(score) {
$this_1.scores[$this_1.num_scores] = score;
    $this_1.num_scores++;
}
$p.addMethod($this_1, 'AddScore', AddScore$1, false);
function Draw$0() {
var i =  $this_1.score;
    $p.fill(255);

    var big =  $p.map(i, 0, 10, 10, 120);

    DrawCircleWithTexture($this_1.x, $this_1.y, big, $this_1.img);
    $p.textAlign($p.CENTER);
    $p.fill(0);
}
$p.addMethod($this_1, 'Draw', Draw$0, false);
function $constr_7(sc, nm, num_teams, nam, xS, yS, rad){
$superCstr();

$this_1.score = sc;
    $this_1.name = nam;
    $this_1.num = nm;
    $this_1.theta = 2 * $p.PI / num_teams * $this_1.num;
    $this_1.x = rad * $p.cos($this_1.theta) + xS / 2;
    $this_1.y = rad * $p.sin($this_1.theta) + yS / 2;
    $p.println("Before " + nam);
    $this_1.img = $p.loadImage(nam + ".png");
    $p.println("After " + nam);
    $this_1.img.loadPixels();
    var cnt =  0;
    $this_1.msk = $p.createImage($this_1.img.width, $this_1.img.height, $p.ARGB);
    $this_1.msk.loadPixels();
    for (var i =  0;  i < $this_1.img.pixels.getLength();  ++i) {
var t =  $this_1.img.pixels.getPixel(i);
      $this_1.msk.pixels.setPixel(i, t);
      if ($p.red(t) == 252 && $p.blue(t) == 252 && $p.green(t) == 254) {
cnt++;
                 $this_1.msk.pixels.setPixel(i, $p.color(back, 0));
}
}
    $this_1.msk.updatePixels();
    $this_1.img = $this_1.msk;
    $this_1.img.updatePixels();
}

function $constr_3(sc, x_, y_){
$superCstr();

$this_1.score = sc;
    $this_1.x = x_;
    $this_1.y = y_;
}

function $constr() {
if(arguments.length === 7) { $constr_7.apply($this_1, arguments); } else if(arguments.length === 3) { $constr_3.apply($this_1, arguments); } else $superCstr();
}
$constr.apply(null, arguments);
}
return Team;
})();
$p.Team = Team;

var table = null;

var maxScore =  0;
var minScore =  1;

function DrawCircleWithTexture(x, y, size, img) {
$p.ellipse(x, y, size + 7, size + 7);
  $p.image(img, x - size/2, y - size/2, size, size);
}
$p.DrawCircleWithTexture = DrawCircleWithTexture;

var back =  $p.color(250, 250, 250);

var teams_circ =  new $p.ArrayList();
var teams_div =  new $p.ArrayList();

var div_counts =  new $p.HashMap();
var divisions =  new $p.HashMap();

var division_position =  new $p.HashMap();
function MakeDivisions() {
divisions.put("Houston Texans", "AFCS");
  divisions.put("Indianapolis Colts", "AFCS");
  divisions.put("Jacksonville Jaguars", "AFCS");
  divisions.put("Tennessee Titans", "AFCS");

  divisions.put("Denver Broncos", "AFCW");
  divisions.put("Kansas City Chiefs", "AFCW");
  divisions.put("Oakland Raiders", "AFCW");
  divisions.put("San Diego Chargers", "AFCW");

  divisions.put("Baltimore Ravens", "AFCN");
  divisions.put("Cincinnati Bengals", "AFCN");
  divisions.put("Cleveland Browns", "AFCN");
  divisions.put("Pittsburgh Steelers", "AFCN");

  divisions.put("Buffalo Bills", "AFCE");
  divisions.put("Miami Dolphins", "AFCE");
  divisions.put("New England Patriots", "AFCE");
  divisions.put("New York Jets", "AFCE");

  divisions.put("Chicago Bears", "NFCN");
  divisions.put("Detroit Lions", "NFCN");
  divisions.put("Green Bay Packers", "NFCN");
  divisions.put("Minnesota Vikings", "NFCN");

  divisions.put("Atlanta Falcons", "NFCS");
  divisions.put("Carolina Panthers", "NFCS");
  divisions.put("New Orleans Saints", "NFCS");
  divisions.put("Tampa Bay Buccaneers", "NFCS");

  divisions.put("Dallas Cowboys", "NFCE");
  divisions.put("New York Giants", "NFCE");
  divisions.put("Philadelphia Eagles", "NFCE");
  divisions.put("Washington Redskins", "NFCE");

  divisions.put("Arizona Cardinals", "NFCW");
  divisions.put("St. Louis Rams", "NFCW");
  divisions.put("San Francisco 49ers", "NFCW");
  divisions.put("Seattle Seahawks", "NFCW");

  div_counts.put("AFCS", 0);
  div_counts.put("AFCN", 0);
  div_counts.put("AFCE", 0);
  div_counts.put("AFCW", 0);
  div_counts.put("NFCS", 0);
  div_counts.put("NFCN", 0);
  div_counts.put("NFCE", 0);
  div_counts.put("NFCW", 0);
  var xPos =  200;
  var yPos =  135;
  division_position.put("AFCS", new $p.PVector(xPos, yPos + 250 * 2));
  division_position.put("AFCN", new $p.PVector(xPos, yPos + 250 * 1));
  division_position.put("AFCE", new $p.PVector(xPos, yPos + 250 * 0));
  division_position.put("AFCW", new $p.PVector(xPos, yPos + 250 * 3));
  xPos = 600;
  division_position.put("NFCS", new $p.PVector(xPos, yPos + 250 * 2));
  division_position.put("NFCN", new $p.PVector(xPos, yPos + 250 * 1));
  division_position.put("NFCE", new $p.PVector(xPos, yPos + 250 * 0));
  division_position.put("NFCW", new $p.PVector(xPos, yPos + 250 * 3));
}
$p.MakeDivisions = MakeDivisions;

function setup() {
MakeDivisions();
  $p.size(800, 1000);
  $p.background(255);
  var cnt =  0;
  table = loadTable("scores.csv");
  for (var $it0 = new $p.ObjectIterator( table.rows ()), r  = void(0); $it0.hasNext() && ((r  = $it0.next()) || true);) cnt++;
  var i =  0;

  for (var $it1 = new $p.ObjectIterator( table.rows ()), r  = void(0); $it1.hasNext() && ((r  = $it1.next()) || true);) {
$p.println(r.getString(0));
    var div =  divisions.get(r.getString(0));
    teams_circ.add(new Team(r.getFloat(1), i, cnt, r.getString(0), $p.width, $p.height,400));
    var div_pos =  division_position.get(div);
    $p.println("After first add");
    $p.println(r.getFloat(1));
    $p.println($p.parseInt(div_counts.get(div)));
    $p.println("After cheks");
    var scr =  r.getFloat(1);
    teams_div.add(new Team(scr, $p.parseInt(div_counts.get(div)), 4, r.getString(0), div_pos.x * 2, div_pos.y * 2,$p.map(scr,0,10,.95,1) * 80));
    div_counts.put(div, div_counts.get(div) + 1);
    i++;
}
  $p.line($p.width / 2, 0,$p.width / 2, $p.height);
  $p.println("Successful setup");
}
$p.setup = setup;

function draw() {
for (var $it2 = new $p.ObjectIterator( teams_div), t  = void(0); $it2.hasNext() && ((t  = $it2.next()) || true);) t.Draw();
 $p.saveFrame("first_draft.png");
 $p.noLoop();
}
$p.draw = draw;
