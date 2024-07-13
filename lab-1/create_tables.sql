create table "group" (
    id serial primary key,
    name varchar(50)
);

create table human (
    id serial primary key,
    name varchar(50),
    group_id integer,
    foreign key (group_id) references "group" (id)
);

create table place (
    id serial primary key,
    name varchar(50)
);

create table object (
    id serial primary key,
    name varchar(50),
    eatable boolean,
    place_id integer,
    foreign key (place_id) references place (id)
);

create table replacing_description (
    id serial primary key,
    description text
);

create table replacing (
    id serial primary key,
    description_id integer,
    foreign key (description_id) references replacing_description (id),
    human_id integer,
    foreign key (human_id) references human (id),
    "from" integer,
    foreign key ("from") references place (id),
    "to" integer,
    foreign key ("to") references place (id)
);

create table action_description (
    id serial primary key,
    human_id integer,
    foreign key (human_id) references human (id),
    description text
);

create table action_with_group (
    id serial primary key,
    description_id integer,
    foreign key (description_id) references action_description (id),
    group_id integer,
    foreign key (group_id) references "group" (id)
);

create table action_with_object (
    id serial primary key,
    description_id integer,
    foreign key (description_id) references action_description (id),
    object_id integer,
    foreign key (object_id) references object (id)
);