import java.util.Map;

Table table;

float maxScore = 0;
float minScore = 1;


void DrawCircleWithTexture(float x, float y, float size, PImage img) {
  ellipse(x, y, size + 7, size + 7);
  image(img, x - size/2, y - size/2, size, size);
  
}

class Team {
  float score;
  String name;
  int num;
  float theta;
  float x;
  float y;
  PImage img;
  PImage msk;
  int num_scores = 0;
  float[] scores = new float[1000];

  void AddScore(float score) {
    scores[num_scores] = score;
    num_scores++;
  }

  Team(float sc, int nm, int num_teams, String nam, float xS, float yS, float rad) {
    score = sc;
    name = nam;
    num = nm;
    theta = 2 * PI / num_teams * num;
    x = rad * cos(theta) + xS / 2;
    y = rad * sin(theta) + yS / 2;
    println("Before " + nam);
    img = loadImage(nam + ".png");
    println("After " + nam);
    img.loadPixels();
    int cnt = 0;
    msk = createImage(img.width, img.height, ARGB);
    msk.loadPixels();
    for (int i = 0; i < img.pixels.length; ++i) {
      color t = img.pixels[i];
      msk.pixels[i] = t;
      if (red(t) == 252 && blue(t) == 252 && green(t) == 254) {
        cnt++;
        //img.pixels[i] = color(back,0);
        msk.pixels[i] = color(back, 0);
      }
    }
    msk.updatePixels();
    img = msk;
    img.updatePixels();
  }

  Team(float sc, int x_, int y_) {
    score = sc;
    x = x_;
    y = y_;
  }

  void Draw() {
    float i = score;
    fill(255);

    float big = map(i, 0, 10, 10, 120);

    DrawCircleWithTexture(x, y, big, img);
    textAlign(CENTER);
    fill(0);
    //text((int)big, x + 50 * cos(theta), y + 50 * sin(theta));
    //line(x + 20 * cos(theta), y + 20 * sin(theta), x + 40 * cos(theta), y + 40 * sin(theta));
  }
}

color back = color(250, 250, 250);

ArrayList<Team> teams_circ = new ArrayList<Team>();
ArrayList<Team> teams_div = new ArrayList<Team>();

HashMap<String, Integer> div_counts = new HashMap<String, Integer>();
HashMap<String, String> divisions = new HashMap<String, String>();


HashMap<String, PVector> division_position = new HashMap<String, PVector>();
void MakeDivisions() {
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
  int xPos = 200;
  int yPos = 135;
  division_position.put("AFCS", new PVector(xPos, yPos + 250 * 2));
  division_position.put("AFCN", new PVector(xPos, yPos + 250 * 1));
  division_position.put("AFCE", new PVector(xPos, yPos + 250 * 0));
  division_position.put("AFCW", new PVector(xPos, yPos + 250 * 3));
  xPos = 600;
  division_position.put("NFCS", new PVector(xPos, yPos + 250 * 2));
  division_position.put("NFCN", new PVector(xPos, yPos + 250 * 1));
  division_position.put("NFCE", new PVector(xPos, yPos + 250 * 0));
  division_position.put("NFCW", new PVector(xPos, yPos + 250 * 3));
}


void setup() {
  MakeDivisions();
  size(800, 1000);
  background(255);
  int cnt = 0;
  table = loadTable("scores.csv");
  for (TableRow r : table.rows ()) cnt++;
  int i = 0;

  for (TableRow r : table.rows ()) {
    println(r.getString(0));
    String div = divisions.get(r.getString(0));
    teams_circ.add(new Team(r.getFloat(1), i, cnt, r.getString(0), width, height,400));
    PVector div_pos = division_position.get(div);
    println("After first add");
    println(r.getFloat(1));
    println(int(div_counts.get(div)));
    println("After cheks");
    float scr = r.getFloat(1);
    teams_div.add(new Team(scr, int(div_counts.get(div)), 4, r.getString(0), div_pos.x * 2, div_pos.y * 2,map(scr,0,10,.95,1) * 80));
    div_counts.put(div, div_counts.get(div) + 1);
    i++;
  }
  line(width / 2, 0,width / 2, height);
  println("Successful setup");
}

void draw() {
 for (Team t : teams_div) t.Draw();
 saveFrame("first_draft.png");
 noLoop();
}







