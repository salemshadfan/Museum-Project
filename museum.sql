CREATE SCHEMA `museum`;
USE `museum`;

CREATE TABLE EXHIBITIONS (
    Ex_no INT PRIMARY KEY,
    Name VARCHAR(255),
    Start_date DATE,
    End_date DATE
);


CREATE TABLE ART_OBJECTS (
    Id_no INT PRIMARY KEY,
    Artist VARCHAR(255),
    Year INT,
    Title VARCHAR(255),
    Descrip TEXT,
    Type ENUM('PAINTING', 'SCULPTURE', 'STATUE', 'OTHER') NOT NULL,
    Category ENUM('PERMANENT_COLLECTION', 'BORROWED') NOT NULL,
    Origin VARCHAR(255),
    Epoch VARCHAR(255),
    FOREIGN KEY (Ex_no) REFERENCES EXHIBITIONS(Ex_no)
);


CREATE TABLE PAINTING (
    Id_no INT PRIMARY KEY,
    Paint_type VARCHAR(255),
    Drawn_on VARCHAR(255),
    Style VARCHAR(255),
    FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no)
);


CREATE TABLE SCULPTURE_STATUE (
    Id_no INT PRIMARY KEY,
    Material VARCHAR(255),
    Height DECIMAL(5,2),
    Weight DECIMAL(5,2),
    Style VARCHAR(255),
    FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no)
);


CREATE TABLE OTHER_ART_OBJECTS (
    Id_no INT PRIMARY KEY,
    Type VARCHAR(255),
    Style VARCHAR(255),
    FOREIGN KEY (Id_no) REFERENCES ART_OBJECTS(Id_no)
);


CREATE TABLE ARTIST (
    Name VARCHAR(255) PRIMARY KEY,
    Date_born INT,
    Date_died INT,
    Origin VARCHAR(255),
    Epoch VARCHAR(255),
    Main_style VARCHAR(255),
    Description TEXT
);




CREATE TABLE COLLECTIONS (
    Col_id INT PRIMARY KEY,
    Name VARCHAR(255),
    Type ENUM('museum', 'personal'),
    Description TEXT,
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Contact_person VARCHAR(255)
);



CREATE TABLE USERS (
    User_id INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role ENUM('admin', 'data_entry', 'end_user') NOT NULL,
    Status ENUM('active', 'blocked') NOT NULL DEFAULT 'active'
);


CREATE TABLE BORROWED (
    Id_no INT PRIMARY KEY,
    Borrowed_from VARCHAR(255),
    Date_borrowed INT,
    Date_returned INT,
    FOREIGN KEY(Id_no) REFERENCES ART_OBJECTS(Id_no)
);


CREATE TABLE PERMANENT_COLLECTION (
    Id_no INT PRIMARY KEY,
    Cost DECIMAL(10,2),
    Date_acquired INT,
    Status ENUM('on display', 'on loan', 'stored'),
    FOREIGN KEY(Id_no) REFERENCES ART_OBJECTS(Id_no)
);

INSERT INTO EXHIBITIONS (Ex_no, Name, Start_date, End_date)
VALUES (1, 'The Tudors: Art and Majesty in Renaissance England', '2022-10-10', '2023-01-08'),
       (2, 'Cubism and the Trompe l’Oeil Tradition', '2022-10-20', '2023-01-22'),
       (3, 'Leonardo Da Vinci', '2019-10-24', '2020-02-24'); 

INSERT INTO ARTIST (Name, Date_born, Date_died, Origin, Epoch, Main_style, Description)
VALUES ('Pietro Torrigiano', 1472, 1528, 'Italy', 'Renaissance', 'Sculptures', 'Torrigiano was a Florentine sculptor and painter who became the first proponent of the Italian Renaissance style in England. He was a student, along with Michelangelo, of Bertoldo di Giovanni at the Academy of Lorenzo de Medici. Torrigiano left Florence and worked in Rome, Bologna, Siena, and Antwerp before making his reputation in England.'),
       ('Pasquier Grenier of Tournai', 1447, 1490, 'Belgium', 'Renaissance', 'Tapestry', 'Pasquier Grenier (1447-1493) was a Flemish tapestry and wine merchant working in Tournai, and the greater region under the control of the Dukes of Burgundy. Once believed to be a master tapestry weaver, archival documents reveal that he was actually one of the most prominent tapestry dealers of the fifteenth-century in Western Europe.'),
       ('Hans Holbein the Younger', 1497, 1543, 'Germany', 'Renaissance', 'Portrait', 'Hans Holbein the Younger was a German-Swiss painter and printmaker who worked in a Northern Renaissance style, and is considered one of the greatest portraitists of the 16th century. He also produced religious art, satire, and Reformation propaganda, and he made a significant contribution to the history of book design.'),
       ('Pablo Picasso', 1881, 1973, 'Spain', 'Crystal Period', 'Cubism', 'Pablo Picasso was a Spanish painter, sculptor, printmaker, ceramicist, and theatre designer who spent most of his adult life in France. One of the most influential artists of the 20th century, he is known for co-founding the Cubist movement, the invention of constructed sculpture, the co-invention of collage, and for the wide variety of styles that he helped develop and explore.'),
       ('Juan Fernandez', 1629, 1657, 'Spain', 'Trompe l’Oeil', 'Still Life', 'Juan Fernández, nicknamed El Labrador, was a Spanish Baroque painter active between 1629 and 1636, specializing in still life painting.'),
       ('Niderviller', 1735, NULL, 'France', 'Trompe l’Oeil', 'Pottery', 'Niderviller faience (German Niederweiler) is one of the most famous French pottery manufacturers. It has been located in the village of Niderviller, Lorraine, France since 1735. It began as a maker of faïence (tin-glazed earthenware), and returned to making this after a period in the mid-18th century when it also made hard-paste porcelain.'),
       ('Georges Braque', 1882, 1963, 'France', 'Cubism', 'Fauvism', 'Georges Braque was a major 20th-century French painter, collagist, draftsman, printmaker and sculptor. His most notable contributions were in his alliance with Fauvism from 1905, and the role he played in the development of Cubism. His work between 1908 and 1912 is closely associated with that of his colleague Pablo Picasso.'),
       ('Marcos Correa', 1646, 1705, 'Spain', 'Trompe l’Oeil', 'Still Life', 'Marcos Correa was a pioneer of trompe l’oeil easel painting in Spain. He was active between 1667 and 1673.'),
       ('Leonardo da Vinci', 1452, 1519, 'Italy', 'Renaissance', 'High Renaissance, naturalism', 'Leonardo da Vinci, born on April 15, 1452, in Vinci, Italy, was a polymath of the Renaissance era. His diverse talents included painting, sculpting, architecture, science, mathematics, engineering, anatomy, and music. He is known for his iconic use of the "sfumato" painting technique, as well as his meticulous attention to detail, anatomical accuracy, and a keen interest in capturing the natural world. His works often displayed a harmonious balance between light and shadow, contributing to the overall sense of depth and realism in his paintings. His notebooks, filled with sketches and observations, reflect his insatiable curiosity and pioneering contributions to various fields, making him one of the most iconic figures in art and intellectual history.'),
       ('Albrecht Dürer', 1471, 1528, 'Germany', 'Renaissance', 'Northern Renaissance, realism', 'Albrecht Dürer was a German painter, printmaker, and theorist of the German Renaissance, born on May 21, 1471. His work is characterized by a combination of Northern European and Italian Renaissance influences. His paintings and prints are known for their meticulous detail, technical skill, and a focus on realism. Dürer was versatile and explored various styles throughout his career, adapting elements from the Italian Renaissance, such as proportion and perspective, into his Northern European artistic tradition.');


INSERT INTO ART_OBJECTS (Id_no, Artist, Year, Title, Descrip, Type, Category, Origin, Epoch, Ex_no)
VALUES (1, 'Dirck Vellert', 1535, 'Martyrdom of the Seven Maccabee Brothers and Their Mother', 'The Old Testament tells the horrific story of King Antiochus IV Epiphanes murdering a Jewish family for their refusal to eat pork, a narrative of religious persecution that would have resonated with many groups in sixteenth-century Northern Europe. In his rendering, celebrated Antwerp artist Vellert relegated the gruesome subject matter to the background while showcasing his mastery of figural narrative and technical dexterity in stained glass.', 'OTHER', 'PERMANENT_COLLECTION', 'Netherlands', 'Renaissance', 1),
       (2, 'Robert Peake', 1603, 'Henry Frederick (1594-1612), Prince of Wales, with Sir John Harington (1592-1614), in the Hunting Field', 'This royal hunting portrait was modeled after an earlier type established by Netherlandish and German artists. The young Prince Henry sheaths his sword while his companion, Sir John Harington, holds the deer’s antlers. The light palette and rich decorative effect are hallmarks of Peake’s style.', 'PAINTING', 'PERMANENT_COLLECTION', 'Britain', 'Renaissance', 1),
       (3, 'Pietro Torrigiano', 1515, 'Portrait Bust of John Fisher, Bishop of Rochester', 'The subject was traditionally identified as John Fisher, Bishop of Rochester and confessor to Henry VIII’s first queen, Catherine of Aragon, but the identification has been increasingly called into question.', 'SCULPTURE', 'PERMANENT_COLLECTION', 'Italy', 'Renaissance', 1),
       (4, 'Pasquier Grenier of Tournai', 1490, 'Andromache and Priam Urging Hector Not to Go to War (from Scenes from the Story of the Trojan War)', 'Inscription: (above, in French): [A]NDROMATA LA MORT HECTOR DOUBTANS. QU[AVOI]T SOG [IE VINT A] GENOS PLOURER / [LU]I PUTA EN GRANS PLEURS CES ENFANS. EN LUI PRIANT E[N CE] JOUR NON ALLER. / [EN] BATAILLE HECTOR SE FIST ARMER. CE NON OSTANT ET ACHEVAL MONTA. / [LE] ROY PRIAT LE CONSTRAIT RETOURNER. PAR LA PITIE QUIL PRINT DADROMATA.', 'OTHER', 'PERMANENT_COLLECTION', 'Netherlands', 'Renaissance', 1),
       (5, 'Hans Holbein the Younger', 1532, 'Hermann von Wedigh III (died 1560)', 'A young man rests his arm on a table. A book lies before him, a piece of paper tucked into its pages. From these simple ingredients, Holbein composed one of his most celebrated—and best preserved—portraits. The sitter came from a prominent family in Cologne, Germany, and served as a judge and alderman of the city’s assembly.', 'PAINTING', 'PERMANENT_COLLECTION', 'Germany', 'Renaissance', 1),
       (6, 'Pablo Picasso', 1914, 'Still Life', 'Still Life may appear to be casually concocted from scrap materials but is rife with playful allusions to favorite motifs of trompe l’oeil painters: a table that thrusts forward, a precariously balanced knife, a cut-crystal glass half full of wine, and the leftovers of a meal.', 'SCULPTURE', 'PERMANENT_COLLECTION', 'France', 'Cubism', 2),
       (7, 'Juan Fernández', 1636, 'Still Life with Four Bunches of Grapes', 'Pliny the Elder’s origin story of eye-deceiving illusionism and creative competition, recounted on the wall at right, influenced artists in the Renaissance and for centuries after. Still-life painting emerged in the 1600s as a fully independent subject in European art, and grapes and curtains became popular motifs for artists aiming to vaunt their skills.', 'PAINTING', 'PERMANENT_COLLECTION', 'Spain', 'Trompe l’Oeil', 2),
       (8, 'Niderviller', 1774, 'Dessert Plate', 'The trompe l’oeil motif of a print attached to wood planking by nails or sealing wax became so popular that during the second half of the eighteenth century many factories imitated it on tableware. Typically, the miniature faux prints depict landscapes with buildings and tiny figures; delicately executed cast shadows make the paper appear to lift.', 'OTHER', 'PERMANENT_COLLECTION', 'France', 'Trompe l’Oeil', 2),
       (9, 'Pablo Picasso', 1914, 'The Absinthe Glass', 'In an age when sculpture usually meant allegorical figures and portrait busts, Picasso’s life-size rendering of a glass of alcohol was shocking for its banality. Cast in bronze in an edition of six, and then hand-painted, none of the finished works is colored green, so it was clearly not absinthe’s distinctive color that inspired Picasso.', 'SCULPTURE', 'PERMANENT_COLLECTION', 'France', 'Cubism', 2),
       (10, 'Georges Braque', 1912, 'Still Life with Violin', 'Braque produced the first-ever Cubist papiers collés in autumn 1912 when he pasted strips of imitation wood-grain wallpaper into his drawings. The resemblance to the flat wood boards beloved of trompe l’oeil painters is striking. Here, the faux pine stands for the wood of both the violin and the paneling on which it hangs, effectively fusing foreground and background.', 'OTHER', 'PERMANENT_COLLECTION', 'France', 'Cubism', 2),
       (11, 'Georges Braque', 1914, 'Still Life (Glass and Cigarette Pack)', 'This collage contains a rare autobiographical reference by Braque, who was a keen cyclist: the fragment of an ad for the bimonthly magazine Le Cyclotouriste. The work likely dates from around June 28, 1914, when the artist embarked on a bicycle trip from Sens to Sorgues (a distance of some 370 miles).', 'PAINTING', 'PERMANENT_COLLECTION', 'France', 'Cubism', 2),
       (12, 'Marcos Correa', 1673, 'Trompe l’Oeil', 'Correa was a pioneer of trompe l’oeil easel painting in Spain. This panel, which is one of a pair, is typically self-reflexive in depicting the artist’s paint-daubed palette, bottle of oil, and maulstick (used to support the hand holding the paintbrush).', 'PAINTING', 'PERMANENT_COLLECTION', 'Spain', 'Trompe l’Oeil', 2),
       (13, 'Leonardo da Vinci', 1519, 'Portrait of Lisa Gherardini, wife of Francesco del Giocondo, known as the Mona Lisa', 'The Mona Lisa, painted by Leonardo da Vinci between 1503 and 1506, is renowned for its enigmatic smile and compelling gaze. The subject, Lisa Gherardini, exudes a timeless elegance and sits against a landscape that gradually fades into the background. The masterful use of sfumato technique, delicate brushstrokes, and subtle color transitions contributes to the painting’s enduring allure and status as an iconic masterpiece of the Renaissance era.', 'PAINTING', 'BORROWED', 'Italy', 'Renaissance', 3),
       (14, 'Leonardo da Vinci', 1482, 'Drapery for a Seated Figure', '"Drapery for a Seated Figure" is a painting by Leonardo da Vinci, showcasing his unparalleled mastery in depicting the play of light and shadow on fabric. The artwork exemplifies his meticulous observation and rendering of the intricate folds and textures of the drapery. The piece is a testament to Da Vinci’s enduring influence on the art of anatomical precision and the nuanced representation of materials.', 'PAINTING', 'BORROWED', 'Italy', 'Renaissance', 3),
       (15, 'Leonardo da Vinci', 1480, 'Study for the Madonna with the Fruit Bowl', 'Leonardo da Vinci’s "Study for the Madonna with the Fruit Bowl" is a preparatory sketch that showcases his meticulous attention to anatomical details and facial expressions. The study reveals Da Vinci’s innovative approach to capturing the serene yet emotive qualities of the Madonna. The artist’s use of hatching and shading highlights his mastery of chiaroscuro, adding depth and realism to the depiction.', 'PAINTING', 'BORROWED', 'Italy', 'Renaissance', 3),
       (16, 'Leonardo da Vinci', 1500, 'Portrait of Isabella d’Este', 'Leonardo da Vinci’s "Portrait of Isabella d’Este" depicts a Renaissance noblewoman, whom he met during the French invasion of Italy in 1499. Painted using black, red, and yellow pastel chalk, this art piece showcased da Vinci’s immense skill in capturing the intricacies of facial expression and the luxurious details of the sitter’s attire.', 'PAINTING', 'BORROWED', 'Italy', 'Renaissance', 3),
       (17, 'Leonardo da Vinci', 1497, 'La Belle Ferronnière', '"La Belle Ferronnière" is a portrait created by Leonardo da Vinci around 1490-1497. Its subject, often speculated to be a woman from the Milanese aristocracy, is depicted with a serene expression and an enigmatic smile. In the nineteenth century, this work was much admired and widely copied, though no other artist managed to capture the beautiful modeling of the face.', 'PAINTING', 'BORROWED', 'Italy', 'Renaissance', 3),
       (18, 'Albrecht Dürer', 1493, 'Portrait of the Artist Holding a Thistle', 'Albrecht Dürer’s first painted self-portrait, possibly an engagement portrait - the thistle or panicaut (eryngium), which Dürer is holding, would in this case be a symbol of marital fidelity.', 'PAINTING', 'BORROWED', 'Germany', 'Renaissance', 3);


INSERT INTO BORROWED (Id_no, Borrowed_from, Date_borrowed, Date_returned)
VALUES (13, 'Francis I, King of France', 1793, 1972),
       (14, 'The Saint-Morys Collection', 1793, 1854),
       (15, 'Aimé Charles Horace His de la Salle', 1878, 1995),
       (16, 'Giuseppe Vallardi', 1860, 1883),
       (17, 'Former royal collection', 1793, 1886),
       (18, 'Nicolas de Villeroy', 1922, 2007);


INSERT INTO PERMANENT_COLLECTION (Id_no, Date_acquired, Status, Cost)
VALUES (1, 1917, 'on display', 331000),
       (2, 1944, 'stored', 319000),
       (3, 1936, 'stored', 594000),
       (4, 1939, 'stored', 389000),
       (5, 1950, 'on display', 168000),
       (6, 1969, 'stored', 904000),
       (7, 2006, 'stored', 199000),
       (8, 1950, 'stored', 50000),
       (9, 1991, 'stored', 967000),
       (10, 1913, 'stored', 306000),
       (11, 1947, 'stored', 271000),
       (12, 1982, 'stored', 389000);


INSERT INTO SCULPTURE_STATUE (Id_no, Material, Height, Weight, Style)
VALUES (3, 'Terracotta', 61.6, 28.1, 'Bust'),
       (6, 'Wood', 25.4, 5, 'Cubism'),
       (9, 'Bronze', 22.5, 17, 'Cubism');

INSERT INTO OTHER_ART_OBJECTS (Id_no, Type, Style)
VALUES (1, 'Mosaic', 'Stained Glass'),
       (4, 'Tapestry', 'Weft'),
       (8, 'Ceramics', 'Dessert Plate'),
       (10, 'Collage', 'Still Life');


INSERT INTO COLLECTIONS (Col_id, Name, Type, Description, Address, Phone, Contact_person)
VALUES (1, 'Renaissance Art Museum', 'museum', 'A museum dedicated to Renaissance art', '123 Art Street, Artville', '123-456-7890', 'John Doe'),
       (2, 'Modern Art Collection', 'personal', 'A personal collection of modern art', '456 Modern Lane, New City', '987-654-3210', 'Jane Smith');


INSERT INTO PAINTING (Id_no, Paint_type, Drawn_on, Style)
VALUES (2, 'Oil', 'Canvas', 'Portrait'),
       (5, 'Oil', 'Oak', 'Portrait'),
       (7, 'Oil', 'Canvas', 'Still Life'),
       (11, 'Oil, Watercolour', 'Paperboard', 'Still Life'),
       (12, 'Oil', 'Canvas', 'Still Life'),
       (13, 'Oil', 'Wood (poplar)', 'Portrait'),
       (14, 'Gray tempera, heightened with white', 'Linen canvas', 'Linen sketch'),
       (15, 'Ink', 'Paper', 'Early Renaissance, sketch and study'),
       (16, 'Chalk, pastel chalk', 'Paper', 'Portrait'),
       (17, 'Oil', 'Wood (walnut)', 'Portrait'),
       (18, 'Oil', 'Vellum', 'Self-portrait');


INSERT INTO COLLECTIONS (Col_id, Name, Type, Description, Address, Phone, Contact_person)
VALUES (1, 'Renaissance Art Museum', 'museum', 'A museum dedicated to Renaissance art', '123 Art Street, Artville', '123-456-7890', 'John Doe'),
       (2, 'Modern Art Collection', 'personal', 'A personal collection of modern art', '456 Modern Lane, New City', '987-654-3210', 'Jane Smith');

INSERT INTO PAINTING (Id_no, Paint_type, Drawn_on, Style)
VALUES (2, 'Oil', 'Canvas', 'Portrait'),
       (5, 'Oil', 'Oak', 'Portrait'),
       (7, 'Oil', 'Canvas', 'Still Life'),
       (11, 'Oil, Watercolour', 'Paperboard', 'Still Life'),
       (12, 'Oil', 'Canvas', 'Still Life'),
       (13, 'Oil', 'Wood (poplar)', 'Portrait'),
       (14, 'Gray tempera, heightened with white', 'Linen canvas', 'Linen sketch'),
       (15, 'Ink', 'Paper', 'Early Renaissance, sketch and study'),
       (16, 'Chalk, pastel chalk', 'Paper', 'Portrait'),
       (17, 'Oil', 'Wood (walnut)', 'Portrait'),
       (18, 'Oil', 'Vellum', 'Self-portrait');
INSERT INTO USERS (User_id, Username, Password, Role, is_blocked)
VALUES(1, 'admin','admin','admin',0),
        (2,'dataentry','123','data_entry',0)
        (3,'user','user','end_user',0);

DELIMITER //

CREATE TRIGGER update_references_after_update
AFTER UPDATE ON ART_OBJECTS
FOR EACH ROW
BEGIN
    DECLARE old_Id_no INT;
    DECLARE new_Id_no INT;

    SET old_Id_no = OLD.Id_no;
    SET new_Id_no = NEW.Id_no;


    UPDATE PAINTING
    SET Id_no = new_Id_no
    WHERE Id_no = old_Id_no;


    UPDATE SCULPTURE_STATUE
    SET Id_no = new_Id_no
    WHERE Id_no = old_Id_no;


    UPDATE OTHER_ART_OBJECTS
    SET Id_no = new_Id_no
    WHERE Id_no = old_Id_no;

    UPDATE BORROWED
    SET Id_no = new_Id_no
    WHERE Id_no = old_Id_no;

    UPDATE PERMANENT_COLLECTION
    SET Id_no = new_Id_no
    WHERE Id_no = old_Id_no;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER delete_references_before_delete
BEFORE DELETE ON ART_OBJECTS
FOR EACH ROW
BEGIN

    DELETE FROM PAINTING
    WHERE Id_no = OLD.Id_no;


    DELETE FROM SCULPTURE_STATUE
    WHERE Id_no = OLD.Id_no;


    DELETE FROM OTHER_ART_OBJECTS
    WHERE Id_no = OLD.Id_no;

    DELETE FROM BORROWED
    WHERE Id_no = OLD.Id_no;


    DELETE FROM PERMANENT_COLLECTION
    WHERE Id_no = OLD.Id_no;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER update_art_objects_exhibition
AFTER UPDATE ON EXHIBITIONS
FOR EACH ROW
BEGIN

    UPDATE ART_OBJECTS
    SET Ex_no = NEW.Ex_no
    WHERE Ex_no = OLD.Ex_no;
END;
//

DELIMITER ;