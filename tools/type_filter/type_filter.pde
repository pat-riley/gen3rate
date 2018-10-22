/**
 * pixel mapping. each pixel is translated into a new element (letter)
 * 
 * KEYS
 * 1                 : toogle font size mode (dynamic/static)
 * 2                 : toogle font color mode (color/b&w)
 * arrow up/down     : maximal fontsize +/-
 * arrow right/left  : minimal fontsize +/-
 * s                 : save png
 * p                 : save pdf
 */

import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;


//String inputText = "This constitution is a multi-party contract entered into by the Members by virtue of their use of this blockchain. Article I - Non Violence Members shall not initiate violence or the threat of violence against another Member. Article II - Perjury Member shall be liable for losses caused by false or misleading attestiations and shall forfeit any profit gained thereby.  Article III - Rights The Members grant the right of contract and of private property to each other, therefore no property shall change hands except with the consent of the owner, by a valid Arbitrator’s order, or community referendum. This Constitution creates no positive rights for or between any Members. Article IV - Vote Buying No Member shall offer nor accept anything of value in exchange for a vote of any type, nor shall any Member unduly influence the vote of another. Article V - No Fiduciary  No Member nor SYS token holder shall have fiduciary responsability to support the value of the SYS token. The Members do not authorize anyone to hold assets, borrow, nor contract on behalf of SYS token holders collectively. This blockchain has no owners, managers or fiduciaries; therefore, no Member shall have beneficial interest in more than 10% of the SYS token supply. Article VI - Restitution Each Member agrees that penalties for breach of contract may include, but are not limited to, fines, loss of account, and other restitution. Article VIII  - Open Source Each Member who makes available a smart contract on this blockchain shall be a Developer. Each Developer shall offer their smart contracts via an free and open source license, and each smart contract shall be documented with a Ricardian Contract stating the intent of all parties and naming the Arbitration Forum that will resolve disputes arising from that contract. Article IX - Language Multi-lingual contracts must specify one prevailing language in case of dispute and the author is liable for losses due to their false, misleading, or ambigious attestations of translations.  Article XII - Dispute Resolution All disputes arising out of or in connection with this constitution shall be finally settled under the Rules of Arbitration of the International Chamber of Commerce by one or more arbitrators appointed in accordance with the said Rules. Article XIV - Choice of Law Choice of law for disputes shall be, in order of precedence, this Constitution and the Maxims of Equity. Article XIII - Amending This Constitution and its subordinate documents shall not be amended except by a vote of the Token Holders with no less than 15% vote participation among tokens and no fewer than 10% more Yes than No votes, sustained for 30 continuous days within a 120 day period. Article XV - PublishingMembers may only publish information to the Blockchain that is within their Right to publish. Furthermore, Members voluntarially consent for all Members to perminately and irrevokably retain a copy, analyise, and redistribute all broadcast transactions and derivitive information. Article - Informed Consent All service providers whom produce tools to facilitate the construction and signing of transactions on behalf of other Members shall present the full Ricardian contract terms of this constitution and other referenced contracts. Service providers shall be liable for losses resulting from failure to disclose the full Ricardian contract terms to users. Article XVI - SeverabilitySeverability If any part of this constitution is declared unenforceable or invalid, the remainder will continue to be valid and enforceable. Article XVII - Termination of Agreement A Member is automatically released from all revocable obligations under this Constitution 3 years after the last transaction signed by that Member is incorporated into the blockchain. After 3 years of inactivity an account may be put up for auction and the proceeds distributed to all Members by removing EXAMPLE from circulation. Article XVIII - Developer Liability Members agree to hold software developers harmless for unintentional mistakes made in the expression of contractual intent, whether or not said mistakes were due to actual or perceived negligence. Article XIX - Consideration  All rights and obligations under this Constitution are mutual and reciprocal and of equally significant value and cost to all parties. Article XX - Acceptance A contract is deemed accepted when a member signs a transaction which incorporates a TAPOS proof of a block whose implied state incoporates an ABI and associated Ricardian contracts and said transaction is incorporated into the blockchain. Article XX - Counterparts This Constitution may be executed in any number of counterparts, each of which when executed and delivered shall constitute a duplicate original, but all counterparts together shall constitute a single agreement.";
float fontSizeMax = 13;
float fontSizeMin = 7;
float spacing = 13; // line height
float kerning = 0; // between letters

boolean fontSizeStatic = true;
boolean blackAndWhite = false;

PFont font;
PImage img;

void setup() {
  size(1080,1320);
  smooth(); 
  
  font = createFont("Hack",10);
  
  img = loadImage("pic5.png");
  println(img.width+" x "+img.height);
  
  

  
}

void draw() {
  String[] textfiles = loadStrings("data/constitution.txt");
  String inputText = textfiles[0];
  
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  background(10);
  textAlign(LEFT);
  textAlign(LEFT,CENTER);

  float x = 0, y = 10;
  int counter = 0;

  while (y < height) {
    // translate position (display) to position (image)
    int imgX = (int) map(x, 0,width, 0,img.width);
    int imgY = (int) map(y, 0,height, 0,img.height);
    // get current color
    color c = img.pixels[imgY*img.width+imgX];
    int greyscale = round(red(c)*0.222 + green(c)*0.707 + blue(c)*0.071);

    pushMatrix();
    translate(x, y);

    if (fontSizeStatic) {
      textFont(font, fontSizeMax);
      if (blackAndWhite) fill(greyscale);
      else fill(c);
    } 
    else {
      // greyscale to fontsize
      float fontSize = map(greyscale, 0,255, fontSizeMax,fontSizeMin);
      fontSize = max(fontSize, 1);
      textFont(font, fontSize);
      if (blackAndWhite) fill(0);
      else fill(c);
    } 

    char letter = inputText.charAt(counter);
    text(letter, 0, 0);
    float letterWidth = textWidth(letter) + kerning;
    // for the next letter ... x + letter width
    x = x + letterWidth; // update x-coordinate
    popMatrix();

    // linebreaks
    if (x+letterWidth >= width) {
      x = 0;
      y = y + spacing; // add line height
    }

    counter++;
    if (counter > inputText.length()-1) counter = 0;
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}


void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
  // change render mode
  if (key == '1') fontSizeStatic = !fontSizeStatic;
  // change color stlye
  if (key == '2') blackAndWhite = !blackAndWhite;
  println("fontSizeMin: "+fontSizeMin+"  fontSizeMax: "+fontSizeMax+"   fontSizeStatic: "+fontSizeStatic+"   blackAndWhite: "+blackAndWhite);
}

void keyPressed() {
  // change fontSizeMax with arrowkeys up/down 
  if (keyCode == UP) fontSizeMax += 2;
  if (keyCode == DOWN) fontSizeMax -= 2; 
  // change fontSizeMin with arrowkeys left/right
  if (keyCode == RIGHT) fontSizeMin += 2;
  if (keyCode == LEFT) fontSizeMin -= 2; 

  //fontSizeMin = max(fontSizeMin, 2);
  //fontSizeMax = max(fontSizeMax, 2);
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}