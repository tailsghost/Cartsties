failed to get console mode for stdout: The handle is invalid.
--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE auctions;
DROP DATABASE identity;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:DkSqfwKQMNcINsjQIOEeZQ==$upaV80S74vJ8v3Ugny4GOy7i7H0ZFegXasPdk+MibBk=:lGi1NSVYPa1wUvaJ2mDl9Ui6qsX4nGlz48iNLQbcia0=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "auctions" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auctions; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE auctions WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE auctions OWNER TO postgres;

\connect auctions

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Auctions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Auctions" (
    "Id" uuid NOT NULL,
    "ReservePrice" integer NOT NULL,
    "Seller" text,
    "Winner" text,
    "SoldAmount" integer,
    "CurrentHighBid" integer,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "AuctionEnd" timestamp with time zone NOT NULL,
    "Status" integer NOT NULL
);


ALTER TABLE public."Auctions" OWNER TO postgres;

--
-- Name: InboxState; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InboxState" (
    "Id" bigint NOT NULL,
    "MessageId" uuid NOT NULL,
    "ConsumerId" uuid NOT NULL,
    "LockId" uuid NOT NULL,
    "RowVersion" bytea,
    "Received" timestamp with time zone NOT NULL,
    "ReceiveCount" integer NOT NULL,
    "ExpirationTime" timestamp with time zone,
    "Consumed" timestamp with time zone,
    "Delivered" timestamp with time zone,
    "LastSequenceNumber" bigint
);


ALTER TABLE public."InboxState" OWNER TO postgres;

--
-- Name: InboxState_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."InboxState" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."InboxState_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Items" (
    "Id" uuid NOT NULL,
    "Model" text,
    "Make" text,
    "Year" integer NOT NULL,
    "Color" text,
    "Mileage" integer NOT NULL,
    "ImageUrl" text,
    "AuctionId" uuid NOT NULL
);


ALTER TABLE public."Items" OWNER TO postgres;

--
-- Name: OutboxMessage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OutboxMessage" (
    "SequenceNumber" bigint NOT NULL,
    "EnqueueTime" timestamp with time zone,
    "SentTime" timestamp with time zone NOT NULL,
    "Headers" text,
    "Properties" text,
    "InboxMessageId" uuid,
    "InboxConsumerId" uuid,
    "OutboxId" uuid,
    "MessageId" uuid NOT NULL,
    "ContentType" character varying(256) NOT NULL,
    "MessageType" text NOT NULL,
    "Body" text NOT NULL,
    "ConversationId" uuid,
    "CorrelationId" uuid,
    "InitiatorId" uuid,
    "RequestId" uuid,
    "SourceAddress" character varying(256),
    "DestinationAddress" character varying(256),
    "ResponseAddress" character varying(256),
    "FaultAddress" character varying(256),
    "ExpirationTime" timestamp with time zone
);


ALTER TABLE public."OutboxMessage" OWNER TO postgres;

--
-- Name: OutboxMessage_SequenceNumber_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."OutboxMessage" ALTER COLUMN "SequenceNumber" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."OutboxMessage_SequenceNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: OutboxState; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OutboxState" (
    "OutboxId" uuid NOT NULL,
    "LockId" uuid NOT NULL,
    "RowVersion" bytea,
    "Created" timestamp with time zone NOT NULL,
    "Delivered" timestamp with time zone,
    "LastSequenceNumber" bigint
);


ALTER TABLE public."OutboxState" OWNER TO postgres;

--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- Data for Name: Auctions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Auctions" ("Id", "ReservePrice", "Seller", "Winner", "SoldAmount", "CurrentHighBid", "CreatedAt", "UpdatedAt", "AuctionEnd", "Status") FROM stdin;
155225c1-4448-4066-9886-6786536e05ea	50000	tom	\N	\N	\N	2024-05-06 16:07:29.54028+00	2024-05-06 16:07:29.54028+00	2024-04-26 16:07:29.54028+00	2
3659ac24-29dd-407a-81f5-ecfe6f924b9b	20000	bob	\N	\N	\N	2024-05-06 16:07:29.540283+00	2024-05-06 16:07:29.540283+00	2024-06-23 16:07:29.540284+00	0
466e4744-4dc5-4987-aae0-b621acfc5e39	20000	alice	\N	\N	\N	2024-05-06 16:07:29.54028+00	2024-05-06 16:07:29.54028+00	2024-06-05 16:07:29.54028+00	0
47111973-d176-4feb-848d-0ea22641c31a	150000	alice	\N	\N	\N	2024-05-06 16:07:29.540282+00	2024-05-06 16:07:29.540282+00	2024-05-19 16:07:29.540282+00	0
afbee524-5972-4075-8800-7d1f9d7b0a0c	20000	bob	\N	\N	\N	2024-05-06 16:07:29.540178+00	2024-05-06 16:07:29.540178+00	2024-05-16 16:07:29.540222+00	0
bbab4d5a-8565-48b1-9450-5ac2a5c4a654	0	bob	\N	\N	\N	2024-05-06 16:07:29.540279+00	2024-05-06 16:07:29.540279+00	2024-05-10 16:07:29.540279+00	0
c8c3ec17-01bf-49db-82aa-1ef80b833a9f	90000	alice	\N	\N	\N	2024-05-06 16:07:29.540278+00	2024-05-06 16:07:29.540278+00	2024-07-05 16:07:29.540279+00	0
dc1e4071-d19d-459b-b848-b5c3cd3d151f	20000	bob	\N	\N	\N	2024-05-06 16:07:29.540282+00	2024-05-06 16:07:29.540282+00	2024-06-20 16:07:29.540282+00	0
ecaa89cd-d137-466d-9be4-8138cc96d1ae	0	AndreyXP	\N	\N	\N	2024-05-06 16:16:37.849339+00	2024-05-06 16:16:37.849339+00	2024-05-31 21:00:00+00	0
062087b1-dcca-41dc-8160-502741125dea	0	bob	\N	\N	\N	2024-05-06 16:18:56.106656+00	2024-05-06 16:18:56.106656+00	2024-05-31 21:00:00+00	0
40490065-dac7-46b6-acc4-df507e0d6570	20000	tom	\N	\N	50003	2024-05-06 16:07:29.540283+00	2024-05-06 16:07:29.540283+00	2024-05-26 16:07:29.540283+00	0
f7cbfabe-c958-430f-81c5-5fa3252fd81f	11	AndreyXP	\N	\N	\N	2024-05-09 10:55:58.478402+00	2024-05-09 10:55:58.478402+00	2024-06-01 11:00:00+00	0
db88367d-3367-4491-919e-fcf55d99890d	111	AndreyXP	\N	\N	\N	2024-05-09 10:56:16.851628+00	2024-05-09 10:56:16.851628+00	2024-07-05 21:00:00+00	0
\.


--
-- Data for Name: InboxState; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."InboxState" ("Id", "MessageId", "ConsumerId", "LockId", "RowVersion", "Received", "ReceiveCount", "ExpirationTime", "Consumed", "Delivered", "LastSequenceNumber") FROM stdin;
\.


--
-- Data for Name: Items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Items" ("Id", "Model", "Make", "Year", "Color", "Mileage", "ImageUrl", "AuctionId") FROM stdin;
1f8d4579-7cf6-4d4a-8679-cf6b787c8e2c	SLK	Mercedes	2020	Blue	15001	https://wroom.ru/i/cars2/mercedesbenz_slk_1.jpg	155225c1-4448-4066-9886-6786536e05ea
232b9235-b29b-4e22-b3da-c5ccdbc42710	Model T	Ford	1938	Rust	150150	https://wroom.ru/i/cars2/ford_modelt_1.jpg	3659ac24-29dd-407a-81f5-ecfe6f924b9b
57fa2115-f383-4d0c-ba23-441cf63dd3a6	F-430	Ferrari	2022	Yellow	5000	https://wroom.ru/i/cars2/ferrari_f430_1.jpg	47111973-d176-4feb-848d-0ea22641c31a
5fcc7600-f432-41b2-a410-2629e294b624	GT	Ford	2020	Red	50000	https://wroom.ru/i/cars2/ford_gt_1.jpg	afbee524-5972-4075-8800-7d1f9d7b0a0c
6891ab69-fb43-4874-9d1a-5b3f0cb3699d	TT	Audi	2020	White	25400	https://wroom.ru/i/cars2/audi_tt_1.jpg	40490065-dac7-46b6-acc4-df507e0d6570
6a7e4cfc-419b-4975-b517-8b6f1db070a2	Veyron	Bugatti	2018	Black	15035	https://wroom.ru/i/cars2/bugatti_veyron_1.jpg	c8c3ec17-01bf-49db-82aa-1ef80b833a9f
a4e8e20f-509c-48f0-9b6c-08666eec5d0e	X1	BMW	2017	Red	90000	https://wroom.ru/i/cars2/bmw_x1_3.jpg	466e4744-4dc5-4987-aae0-b621acfc5e39
edc94dca-8567-47f9-b9fe-1cb5edce792b	Spider	Ferrari	2015	Blue	50000	https://wroom.ru/i/cars2/ferrari_f8_1.jpg	dc1e4071-d19d-459b-b848-b5c3cd3d151f
f29c18cd-c532-441c-8ebf-bfba52aa8cf6	Mustang	Ford	2023	Yellow	65125	https://wroom.ru/i/cars2/ford_mustang_6.jpg	bbab4d5a-8565-48b1-9450-5ac2a5c4a654
dc5349b4-0be4-4af3-a3fa-02b8eab58811	Explorer	Ford	2010	https://wroom.ru/i/cars2/ford_gt_1.jpg	1111	https://wroom.ru/i/cars2/ford_explorer_6.jpg	ecaa89cd-d137-466d-9be4-8138cc96d1ae
00422675-eb18-406c-a8d0-5824504e72d7	GT	Ford	2015	Blue	10000	https://wroom.ru/i/cars2/ford_gt_1.jpg	062087b1-dcca-41dc-8160-502741125dea
c217d402-0d11-4614-914a-ef1b96239d3f	GT	Ford	1111	Blue	111	https://wroom.ru/i/cars2/ford_gt_1.jpg	f7cbfabe-c958-430f-81c5-5fa3252fd81f
cb9ecf82-b82f-41e2-ad68-df60be8d66fa	GT	Ford	11111	Blue	11	https://wroom.ru/i/cars2/ford_gt_1.jpg	db88367d-3367-4491-919e-fcf55d99890d
\.


--
-- Data for Name: OutboxMessage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OutboxMessage" ("SequenceNumber", "EnqueueTime", "SentTime", "Headers", "Properties", "InboxMessageId", "InboxConsumerId", "OutboxId", "MessageId", "ContentType", "MessageType", "Body", "ConversationId", "CorrelationId", "InitiatorId", "RequestId", "SourceAddress", "DestinationAddress", "ResponseAddress", "FaultAddress", "ExpirationTime") FROM stdin;
\.


--
-- Data for Name: OutboxState; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OutboxState" ("OutboxId", "LockId", "RowVersion", "Created", "Delivered", "LastSequenceNumber") FROM stdin;
\.


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20240315144442_InitialCreate	8.0.3
20240315223857_fix_init	8.0.3
20240331161443_Outbox	8.0.3
\.


--
-- Name: InboxState_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."InboxState_Id_seq"', 1, false);


--
-- Name: OutboxMessage_SequenceNumber_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OutboxMessage_SequenceNumber_seq"', 8, true);


--
-- Name: InboxState AK_InboxState_MessageId_ConsumerId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InboxState"
    ADD CONSTRAINT "AK_InboxState_MessageId_ConsumerId" UNIQUE ("MessageId", "ConsumerId");


--
-- Name: Auctions PK_Auctions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Auctions"
    ADD CONSTRAINT "PK_Auctions" PRIMARY KEY ("Id");


--
-- Name: InboxState PK_InboxState; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InboxState"
    ADD CONSTRAINT "PK_InboxState" PRIMARY KEY ("Id");


--
-- Name: Items PK_Items; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Items"
    ADD CONSTRAINT "PK_Items" PRIMARY KEY ("Id");


--
-- Name: OutboxMessage PK_OutboxMessage; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OutboxMessage"
    ADD CONSTRAINT "PK_OutboxMessage" PRIMARY KEY ("SequenceNumber");


--
-- Name: OutboxState PK_OutboxState; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OutboxState"
    ADD CONSTRAINT "PK_OutboxState" PRIMARY KEY ("OutboxId");


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: IX_InboxState_Delivered; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_InboxState_Delivered" ON public."InboxState" USING btree ("Delivered");


--
-- Name: IX_Items_AuctionId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Items_AuctionId" ON public."Items" USING btree ("AuctionId");


--
-- Name: IX_OutboxMessage_EnqueueTime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OutboxMessage_EnqueueTime" ON public."OutboxMessage" USING btree ("EnqueueTime");


--
-- Name: IX_OutboxMessage_ExpirationTime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OutboxMessage_ExpirationTime" ON public."OutboxMessage" USING btree ("ExpirationTime");


--
-- Name: IX_OutboxMessage_InboxMessageId_InboxConsumerId_SequenceNumber; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_OutboxMessage_InboxMessageId_InboxConsumerId_SequenceNumber" ON public."OutboxMessage" USING btree ("InboxMessageId", "InboxConsumerId", "SequenceNumber");


--
-- Name: IX_OutboxMessage_OutboxId_SequenceNumber; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_OutboxMessage_OutboxId_SequenceNumber" ON public."OutboxMessage" USING btree ("OutboxId", "SequenceNumber");


--
-- Name: IX_OutboxState_Created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OutboxState_Created" ON public."OutboxState" USING btree ("Created");


--
-- Name: Items FK_Items_Auctions_AuctionId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Items"
    ADD CONSTRAINT "FK_Items_Auctions_AuctionId" FOREIGN KEY ("AuctionId") REFERENCES public."Auctions"("Id") ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "identity" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: identity; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE identity WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE identity OWNER TO postgres;

\connect identity

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AspNetRoleClaims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AspNetRoleClaims" (
    "Id" integer NOT NULL,
    "RoleId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text
);


ALTER TABLE public."AspNetRoleClaims" OWNER TO postgres;

--
-- Name: AspNetRoleClaims_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."AspNetRoleClaims" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."AspNetRoleClaims_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: AspNetRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AspNetRoles" (
    "Id" text NOT NULL,
    "Name" character varying(256),
    "NormalizedName" character varying(256),
    "ConcurrencyStamp" text
);


ALTER TABLE public."AspNetRoles" OWNER TO postgres;

--
-- Name: AspNetUserClaims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AspNetUserClaims" (
    "Id" integer NOT NULL,
    "UserId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text
);


ALTER TABLE public."AspNetUserClaims" OWNER TO postgres;

--
-- Name: AspNetUserClaims_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."AspNetUserClaims" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."AspNetUserClaims_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: AspNetUserLogins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AspNetUserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text,
    "UserId" text NOT NULL
);


ALTER TABLE public."AspNetUserLogins" OWNER TO postgres;

--
-- Name: AspNetUserRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AspNetUserRoles" (
    "UserId" text NOT NULL,
    "RoleId" text NOT NULL
);


ALTER TABLE public."AspNetUserRoles" OWNER TO postgres;

--
-- Name: AspNetUserTokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AspNetUserTokens" (
    "UserId" text NOT NULL,
    "LoginProvider" text NOT NULL,
    "Name" text NOT NULL,
    "Value" text
);


ALTER TABLE public."AspNetUserTokens" OWNER TO postgres;

--
-- Name: AspNetUsers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AspNetUsers" (
    "Id" text NOT NULL,
    "UserName" character varying(256),
    "NormalizedUserName" character varying(256),
    "Email" character varying(256),
    "NormalizedEmail" character varying(256),
    "EmailConfirmed" boolean NOT NULL,
    "PasswordHash" text,
    "SecurityStamp" text,
    "ConcurrencyStamp" text,
    "PhoneNumber" text,
    "PhoneNumberConfirmed" boolean NOT NULL,
    "TwoFactorEnabled" boolean NOT NULL,
    "LockoutEnd" timestamp with time zone,
    "LockoutEnabled" boolean NOT NULL,
    "AccessFailedCount" integer NOT NULL
);


ALTER TABLE public."AspNetUsers" OWNER TO postgres;

--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- Data for Name: AspNetRoleClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AspNetRoleClaims" ("Id", "RoleId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- Data for Name: AspNetRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AspNetRoles" ("Id", "Name", "NormalizedName", "ConcurrencyStamp") FROM stdin;
\.


--
-- Data for Name: AspNetUserClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AspNetUserClaims" ("Id", "UserId", "ClaimType", "ClaimValue") FROM stdin;
1	f0479c76-bc21-4a02-9020-16a32ef1b5be	name	Alice Smith
2	a3b687c5-4e42-4204-9b10-e7a157aa36ac	name	Bob Smith
3	3f9f6bd9-99bf-43e4-b810-445683be1b0b	name	╨Р╨╜╨┤╤А╨╡╨╣ ╨и╤Г╤В╨╛╨▓
\.


--
-- Data for Name: AspNetUserLogins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AspNetUserLogins" ("LoginProvider", "ProviderKey", "ProviderDisplayName", "UserId") FROM stdin;
\.


--
-- Data for Name: AspNetUserRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AspNetUserRoles" ("UserId", "RoleId") FROM stdin;
\.


--
-- Data for Name: AspNetUserTokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AspNetUserTokens" ("UserId", "LoginProvider", "Name", "Value") FROM stdin;
\.


--
-- Data for Name: AspNetUsers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AspNetUsers" ("Id", "UserName", "NormalizedUserName", "Email", "NormalizedEmail", "EmailConfirmed", "PasswordHash", "SecurityStamp", "ConcurrencyStamp", "PhoneNumber", "PhoneNumberConfirmed", "TwoFactorEnabled", "LockoutEnd", "LockoutEnabled", "AccessFailedCount") FROM stdin;
f0479c76-bc21-4a02-9020-16a32ef1b5be	alice	ALICE	AliceSmith@email.com	ALICESMITH@EMAIL.COM	t	AQAAAAIAAYagAAAAEDocXl1kCzWsCcmy2aXInjVujjbMJYk4D0hm9hrVEGbl8YTDYjWWUlIJ0z23wPE8cw==	DVOYJZJMMADMBICGZDKMEC7D3G3W4NPD	520962fd-5c89-4261-b4f1-9a18b3c2a281	\N	f	f	\N	t	0
a3b687c5-4e42-4204-9b10-e7a157aa36ac	bob	BOB	BobSmith@email.com	BOBSMITH@EMAIL.COM	t	AQAAAAIAAYagAAAAEHd/C+4012NFb9ePpJ6S07tGpZDFzX3wrSXbqDW4gQ7H7bKdHszXZEPyVdbG1gI2MQ==	LGQTRFV4XKKW7VLHQJVBVFYXWI7NJXM6	82e906cd-df4f-404c-811a-a54c1fa91899	\N	f	f	\N	t	0
3f9f6bd9-99bf-43e4-b810-445683be1b0b	AndreyXP	ANDREYXP	tailsghost@vk.com	TAILSGHOST@VK.COM	t	AQAAAAIAAYagAAAAEAjC29D06Uc9wL04DPfHMn423JEYaBipzAtDaiV2GGib1UsNGQlWP+gFlTUnJydHdw==	QX6Q3TDYYECPS5H27IPG3KI3C74ZYSDX	fc447cae-d29b-4f4e-935c-0b44e21a59a3	\N	f	f	\N	t	0
\.


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20240404005955_InitialCreate	8.0.3
\.


--
-- Name: AspNetRoleClaims_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AspNetRoleClaims_Id_seq"', 1, false);


--
-- Name: AspNetUserClaims_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AspNetUserClaims_Id_seq"', 3, true);


--
-- Name: AspNetRoleClaims PK_AspNetRoleClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetRoleClaims"
    ADD CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id");


--
-- Name: AspNetRoles PK_AspNetRoles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetRoles"
    ADD CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id");


--
-- Name: AspNetUserClaims PK_AspNetUserClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserClaims"
    ADD CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id");


--
-- Name: AspNetUserLogins PK_AspNetUserLogins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserLogins"
    ADD CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey");


--
-- Name: AspNetUserRoles PK_AspNetUserRoles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserRoles"
    ADD CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId");


--
-- Name: AspNetUserTokens PK_AspNetUserTokens; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserTokens"
    ADD CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name");


--
-- Name: AspNetUsers PK_AspNetUsers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUsers"
    ADD CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id");


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: EmailIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "EmailIndex" ON public."AspNetUsers" USING btree ("NormalizedEmail");


--
-- Name: IX_AspNetRoleClaims_RoleId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON public."AspNetRoleClaims" USING btree ("RoleId");


--
-- Name: IX_AspNetUserClaims_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AspNetUserClaims_UserId" ON public."AspNetUserClaims" USING btree ("UserId");


--
-- Name: IX_AspNetUserLogins_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AspNetUserLogins_UserId" ON public."AspNetUserLogins" USING btree ("UserId");


--
-- Name: IX_AspNetUserRoles_RoleId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON public."AspNetUserRoles" USING btree ("RoleId");


--
-- Name: RoleNameIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "RoleNameIndex" ON public."AspNetRoles" USING btree ("NormalizedName");


--
-- Name: UserNameIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UserNameIndex" ON public."AspNetUsers" USING btree ("NormalizedUserName");


--
-- Name: AspNetRoleClaims FK_AspNetRoleClaims_AspNetRoles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetRoleClaims"
    ADD CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."AspNetRoles"("Id") ON DELETE CASCADE;


--
-- Name: AspNetUserClaims FK_AspNetUserClaims_AspNetUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserClaims"
    ADD CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AspNetUsers"("Id") ON DELETE CASCADE;


--
-- Name: AspNetUserLogins FK_AspNetUserLogins_AspNetUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserLogins"
    ADD CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AspNetUsers"("Id") ON DELETE CASCADE;


--
-- Name: AspNetUserRoles FK_AspNetUserRoles_AspNetRoles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."AspNetRoles"("Id") ON DELETE CASCADE;


--
-- Name: AspNetUserRoles FK_AspNetUserRoles_AspNetUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AspNetUsers"("Id") ON DELETE CASCADE;


--
-- Name: AspNetUserTokens FK_AspNetUserTokens_AspNetUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AspNetUserTokens"
    ADD CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AspNetUsers"("Id") ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

