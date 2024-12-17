BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "users_teacher" (
	"id"	integer NOT NULL,
	"first_name"	varchar(30) NOT NULL,
	"last_name"	varchar(30) NOT NULL,
	"position"	varchar(50) NOT NULL,
	"likes"	integer unsigned NOT NULL CHECK("likes" >= 0),
	"email"	varchar(254) UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "users_post" (
	"id"	integer NOT NULL,
	"title"	varchar(200) NOT NULL,
	"description"	text NOT NULL,
	"posted_on"	datetime NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"likes"	integer unsigned NOT NULL CHECK("likes" >= 0),
	"subject"	varchar(50) NOT NULL,
	"author_id"	bigint NOT NULL,
	"teacher_id"	bigint NOT NULL,
	"slug"	varchar(50) NOT NULL UNIQUE,
	FOREIGN KEY("teacher_id") REFERENCES "users_teacher"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("author_id") REFERENCES "users_author"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "users_author" (
	"id"	integer NOT NULL,
	"first_name"	varchar(30) NOT NULL,
	"last_name"	varchar(30) NOT NULL,
	"total_posts"	integer unsigned NOT NULL CHECK("total_posts" >= 0),
	"date_joined"	date NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	"registration_number"	varchar(40) UNIQUE,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "users_comment" (
	"id"	integer NOT NULL,
	"text"	text NOT NULL,
	"post_id"	bigint NOT NULL,
	"author_id"	bigint,
	FOREIGN KEY("author_id") REFERENCES "users_author"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("post_id") REFERENCES "users_post"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-12-13 14:52:42.225551');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2024-12-13 14:52:42.294054');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2024-12-13 14:52:42.323117');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2024-12-13 14:52:42.346423');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2024-12-13 14:52:42.384590');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2024-12-13 14:52:42.416098');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2024-12-13 14:52:42.434941');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2024-12-13 14:52:42.453212');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2024-12-13 14:52:42.471623');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2024-12-13 14:52:42.491436');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2024-12-13 14:52:42.501663');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2024-12-13 14:52:42.517682');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2024-12-13 14:52:42.540310');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2024-12-13 14:52:42.560262');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2024-12-13 14:52:42.594384');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2024-12-13 14:52:42.612442');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2024-12-13 14:52:42.632438');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2024-12-13 14:52:42.656758');
INSERT INTO "django_migrations" VALUES (19,'users','0001_initial','2024-12-13 14:52:42.697786');
INSERT INTO "django_migrations" VALUES (20,'users','0002_post_slug','2024-12-13 14:52:42.713982');
INSERT INTO "django_migrations" VALUES (21,'users','0003_comment','2024-12-13 15:07:59.379093');
INSERT INTO "django_migrations" VALUES (22,'users','0004_author_user','2024-12-14 05:08:57.182413');
INSERT INTO "django_migrations" VALUES (23,'users','0005_remove_author_registration_number','2024-12-14 05:30:51.603655');
INSERT INTO "django_migrations" VALUES (24,'users','0006_remove_comment_user_email_remove_comment_user_name','2024-12-16 06:34:09.854705');
INSERT INTO "django_migrations" VALUES (25,'users','0007_author_registration_number','2024-12-16 06:41:03.525754');
INSERT INTO "django_migrations" VALUES (26,'users','0008_comment_user','2024-12-16 06:57:35.918483');
INSERT INTO "django_migrations" VALUES (27,'users','0009_remove_comment_user_comment_author','2024-12-16 07:00:11.185669');
INSERT INTO "django_migrations" VALUES (28,'users','0010_alter_author_registration_number','2024-12-16 07:17:05.277018');
INSERT INTO "django_migrations" VALUES (29,'users','0011_alter_comment_author','2024-12-16 07:46:08.182620');
INSERT INTO "django_migrations" VALUES (30,'users','0012_alter_comment_author','2024-12-16 07:46:08.228279');
INSERT INTO "django_admin_log" VALUES (1,'1','Shazim Nawaz',1,'[{"added": {}}]',2,1,'2024-12-13 14:56:40.034348');
INSERT INTO "django_admin_log" VALUES (2,'1','Jawad Afzal',1,'[{"added": {}}]',1,1,'2024-12-13 14:56:56.063678');
INSERT INTO "django_admin_log" VALUES (3,'1','Test Post 1',1,'[{"added": {}}]',3,1,'2024-12-13 14:56:58.717036');
INSERT INTO "django_admin_log" VALUES (4,'1','shazim',2,'[{"changed": {"fields": ["First name", "Last name"]}}]',7,1,'2024-12-14 05:22:57.817560');
INSERT INTO "django_admin_log" VALUES (5,'3','haha',3,'',3,1,'2024-12-14 05:28:25.799155');
INSERT INTO "django_admin_log" VALUES (6,'2','haha',3,'',3,1,'2024-12-14 05:28:30.411700');
INSERT INTO "django_admin_log" VALUES (7,'1','Jawad Afzal',3,'',1,1,'2024-12-14 05:28:48.495859');
INSERT INTO "django_admin_log" VALUES (8,'2','Jawad031',2,'[{"changed": {"fields": ["Active"]}}]',7,1,'2024-12-16 06:50:16.351689');
INSERT INTO "django_admin_log" VALUES (9,'1','Shazim Nawaz',3,'',1,1,'2024-12-16 07:00:34.222870');
INSERT INTO "django_admin_log" VALUES (10,'11','meow',3,'',3,1,'2024-12-16 07:45:44.764856');
INSERT INTO "django_admin_log" VALUES (11,'10','axjn',3,'',3,1,'2024-12-16 07:45:44.764935');
INSERT INTO "django_admin_log" VALUES (12,'9','plal',3,'',3,1,'2024-12-16 07:45:44.764971');
INSERT INTO "django_admin_log" VALUES (13,'8','cwe',3,'',3,1,'2024-12-16 07:45:44.764998');
INSERT INTO "django_admin_log" VALUES (14,'7','pplsxc',3,'',3,1,'2024-12-16 07:45:44.765024');
INSERT INTO "django_admin_log" VALUES (15,'6','wdqwd',3,'',3,1,'2024-12-16 07:45:44.765048');
INSERT INTO "django_admin_log" VALUES (16,'5','How teachers tech!',3,'',3,1,'2024-12-16 07:45:44.765069');
INSERT INTO "django_admin_log" VALUES (17,'3','Shazim Nawaz',3,'',1,1,'2024-12-16 07:46:00.733502');
INSERT INTO "django_admin_log" VALUES (18,'2','Jawad Afzal',3,'',1,1,'2024-12-16 07:46:00.733556');
INSERT INTO "django_admin_log" VALUES (19,'5','Jawad Afzal',3,'',1,1,'2024-12-16 07:55:14.755179');
INSERT INTO "django_admin_log" VALUES (20,'4','Shazim Nawaz',3,'',1,1,'2024-12-16 07:55:14.755239');
INSERT INTO "django_admin_log" VALUES (21,'7','Jawad Afzal',3,'',1,1,'2024-12-16 08:01:41.257942');
INSERT INTO "django_admin_log" VALUES (22,'6','Shazim Nawaz',3,'',1,1,'2024-12-16 08:01:41.258018');
INSERT INTO "django_admin_log" VALUES (23,'8','Shazim Nawaz',3,'',1,1,'2024-12-16 08:06:11.507354');
INSERT INTO "django_admin_log" VALUES (24,'9','Jawad Afzal',3,'',1,1,'2024-12-16 08:08:01.912604');
INSERT INTO "django_admin_log" VALUES (25,'20','new pstt',3,'',3,1,'2024-12-16 14:29:58.147678');
INSERT INTO "django_admin_log" VALUES (26,'19','akjbsc',3,'',3,1,'2024-12-16 14:29:58.147753');
INSERT INTO "django_admin_log" VALUES (27,'18','adjkbk',3,'',3,1,'2024-12-16 14:29:58.147794');
INSERT INTO "django_admin_log" VALUES (28,'21','wec w e',3,'',3,1,'2024-12-16 14:44:32.212087');
INSERT INTO "django_content_type" VALUES (1,'users','author');
INSERT INTO "django_content_type" VALUES (2,'users','teacher');
INSERT INTO "django_content_type" VALUES (3,'users','post');
INSERT INTO "django_content_type" VALUES (4,'admin','logentry');
INSERT INTO "django_content_type" VALUES (5,'auth','permission');
INSERT INTO "django_content_type" VALUES (6,'auth','group');
INSERT INTO "django_content_type" VALUES (7,'auth','user');
INSERT INTO "django_content_type" VALUES (8,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (9,'sessions','session');
INSERT INTO "django_content_type" VALUES (10,'users','comment');
INSERT INTO "auth_permission" VALUES (1,1,'add_author','Can add author');
INSERT INTO "auth_permission" VALUES (2,1,'change_author','Can change author');
INSERT INTO "auth_permission" VALUES (3,1,'delete_author','Can delete author');
INSERT INTO "auth_permission" VALUES (4,1,'view_author','Can view author');
INSERT INTO "auth_permission" VALUES (5,2,'add_teacher','Can add teacher');
INSERT INTO "auth_permission" VALUES (6,2,'change_teacher','Can change teacher');
INSERT INTO "auth_permission" VALUES (7,2,'delete_teacher','Can delete teacher');
INSERT INTO "auth_permission" VALUES (8,2,'view_teacher','Can view teacher');
INSERT INTO "auth_permission" VALUES (9,3,'add_post','Can add post');
INSERT INTO "auth_permission" VALUES (10,3,'change_post','Can change post');
INSERT INTO "auth_permission" VALUES (11,3,'delete_post','Can delete post');
INSERT INTO "auth_permission" VALUES (12,3,'view_post','Can view post');
INSERT INTO "auth_permission" VALUES (13,4,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (14,4,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (15,4,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (16,4,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (17,5,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (18,5,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (19,5,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (20,5,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (21,6,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (22,6,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (23,6,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (24,6,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (25,7,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (26,7,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (27,7,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (28,7,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (29,8,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (30,8,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (31,8,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (32,8,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (33,9,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (34,9,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (35,9,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (36,9,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (37,10,'add_comment','Can add comment');
INSERT INTO "auth_permission" VALUES (38,10,'change_comment','Can change comment');
INSERT INTO "auth_permission" VALUES (39,10,'delete_comment','Can delete comment');
INSERT INTO "auth_permission" VALUES (40,10,'view_comment','Can view comment');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$870000$i0IeKK28oDJabpPHavEqLl$azr5qUUo0hkWBmSlaDdb3WH6EO4UMqD8ewXb/994Who=','2024-12-17 05:00:47.417577',1,'shazim','Nawaz','s.n.bhatti45@gmail.com',1,1,'2024-12-13 14:53:35','Shazim');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$870000$wZyi2S5HGsolu8aiaWsDST$Z7msKljP9KZD46vz6nZz+ew041NjDgIjlqgmzGxXVUw=','2024-12-17 04:59:55.978783',0,'Jawad031','Afzal','sp22-bse-020@cuivehari.edu.pk',0,1,'2024-12-16 06:49:01','Jawad');
INSERT INTO "django_session" VALUES ('wfqgdqob1s73bsysllo6b6o3jtoys5zz','.eJxVjMsOwiAUBf-FtSE8Ugou3fsN5ALnStXQpLQr479rky50e2bmvESkba1x61jiVMRZaHH63RLlB9oOyp3abZZ5busyJbkr8qBdXueC5-Vw_w4q9fqtM6ugffDaWIaDVoO3I0AqMXlGseyzGVSBIVjjSoA2lByNZBMYQbw_8_g49A:1tNPhP:8vUMG54e4lCgIEeSs0znaMdISuhiQnjucIiKDWWHKdU','2024-12-31 05:00:47.432419');
INSERT INTO "users_teacher" VALUES (1,'Shazim','Nawaz','Newbie',0,'S@gmail.com');
INSERT INTO "users_post" VALUES (22,'new post 2','The .question class had conflicting margin rules (margin-bottom and margin), so I combined them into one.
The width in .question was set to auto, which can lead to layout issues in some cases, so I adjusted it for better control.
The .post__content class had display: flex, but you didn''t specify how its children should be aligned. If you want a specific layout (like centering), I added that.
For .subject and .teacher, I updated the positioning to ensure content is positioned correctly.
Fixed some structure issues where p tags with specific classes (like subject and teacher) were styled without proper positioning.','2024-12-16 14:33:12.516155',0,0,'DSA',10,1,'new-post-2');
INSERT INTO "users_post" VALUES (23,'post 2','kjasbha cao icha scasc Tile Design:

Each post (.question) is now displayed as a tile. It has a fixed width, padding, and a subtle shadow on hover to make it interactive.
Responsive Design:

The grid layout automatically adjusts to screen sizes, so on smaller screens, the number of tiles per row will decrease. This ensures the design is mobile-friendly.
Hover Effect:

The tiles have a hover effect (.question:hover) for better interactivity, where the tile raises and gets a subtle shadow when hovered.
This design will display the posts in tiles arranged neatly on the page, without vertical scrolling. Each tile will contain the content of the post, and the layout will adjust to different screen sizes. Let me know if you need further customization!','2024-12-16 15:16:45.103958',0,0,'MAth',10,1,'post-2');
INSERT INTO "users_author" VALUES (10,'Shazim','Nawaz',0,'2024-12-16',1,'');
INSERT INTO "users_author" VALUES (11,'Jawad','Afzal',0,'2024-12-16',2,'bse-020');
INSERT INTO "users_comment" VALUES (13,'kjbdc',22,10);
INSERT INTO "users_comment" VALUES (14,'lkanc  apocnj nasjk',22,10);
INSERT INTO "users_comment" VALUES (15,'ajbc a cdah',22,11);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "users_post_author_id_5106b896" ON "users_post" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "users_post_teacher_id_0339f4cb" ON "users_post" (
	"teacher_id"
);
CREATE INDEX IF NOT EXISTS "users_comment_post_id_fb15d6ef" ON "users_comment" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "users_comment_author_id_daafd36a" ON "users_comment" (
	"author_id"
);
COMMIT;
