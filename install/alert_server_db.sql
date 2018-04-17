--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: alert_server; Type: DATABASE; Schema: -; Owner: alert_server
--

CREATE DATABASE alert_server ;


ALTER DATABASE alert_server OWNER TO alert_server;

\connect alert_server

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alert; Type: TABLE; Schema: public; Owner: alert_server; Tablespace: 
--

CREATE TABLE alert (
    alert_id integer NOT NULL,
    alert_type character(1),
    alert_start timestamp with time zone,
    alert_end timestamp with time zone,
    alert_text text,
    alert_clientgroup_id integer
);


ALTER TABLE public.alert OWNER TO alert_server;

--
-- Name: client; Type: TABLE; Schema: public; Owner: alert_server; Tablespace: 
--

CREATE TABLE client (
    client_id integer NOT NULL,
    client_type character(1),
    client_name character varying(64),
    client_ip character varying(15)
);


ALTER TABLE public.client OWNER TO alert_server;

--
-- Name: clientgroup; Type: TABLE; Schema: public; Owner: alert_server; Tablespace: 
--

CREATE TABLE clientgroup (
    clientgroup_id integer NOT NULL,
    clientgroup_name character varying(50)
);


ALTER TABLE public.clientgroup OWNER TO alert_server;

--
-- Name: clientgroupmember; Type: TABLE; Schema: public; Owner: alert_server; Tablespace: 
--

CREATE TABLE clientgroupmember (
    clientgroup_id integer NOT NULL,
    client_id integer NOT NULL,
    clientgroupmember_type character(1)
);


ALTER TABLE public.clientgroupmember OWNER TO alert_server;

--
-- Name: fk_client_id; Type: CONSTRAINT; Schema: public; Owner: alert_server; Tablespace: 
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_client_id PRIMARY KEY (client_id);


--
-- Name: pk_alert_id; Type: CONSTRAINT; Schema: public; Owner: alert_server; Tablespace: 
--

ALTER TABLE ONLY alert
    ADD CONSTRAINT pk_alert_id PRIMARY KEY (alert_id);


--
-- Name: pk_clientgroup_id; Type: CONSTRAINT; Schema: public; Owner: alert_server; Tablespace: 
--

ALTER TABLE ONLY clientgroup
    ADD CONSTRAINT pk_clientgroup_id PRIMARY KEY (clientgroup_id);


--
-- Name: pk_clientgroupmember; Type: CONSTRAINT; Schema: public; Owner: alert_server; Tablespace: 
--

ALTER TABLE ONLY clientgroupmember
    ADD CONSTRAINT pk_clientgroupmember PRIMARY KEY (clientgroup_id, client_id);


--
-- Name: fk_client; Type: FK CONSTRAINT; Schema: public; Owner: alert_server
--

ALTER TABLE ONLY clientgroupmember
    ADD CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client(client_id);


--
-- Name: fk_clientgroup; Type: FK CONSTRAINT; Schema: public; Owner: alert_server
--

ALTER TABLE ONLY clientgroupmember
    ADD CONSTRAINT fk_clientgroup FOREIGN KEY (clientgroup_id) REFERENCES clientgroup(clientgroup_id);


--
-- Name: fk_clientgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: alert_server
--

ALTER TABLE ONLY alert
    ADD CONSTRAINT fk_clientgroup_id FOREIGN KEY (alert_clientgroup_id) REFERENCES clientgroup(clientgroup_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: alert_server
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM alert_server;
GRANT USAGE ON SCHEMA public TO alert_server;


--
-- Name: alert; Type: ACL; Schema: public; Owner: alert_server
--

REVOKE ALL ON TABLE alert FROM PUBLIC;
REVOKE ALL ON TABLE alert FROM alert_server;
GRANT ALL ON TABLE alert TO alert_server;


--
-- Name: client; Type: ACL; Schema: public; Owner: alert_server
--

REVOKE ALL ON TABLE client FROM PUBLIC;
REVOKE ALL ON TABLE client FROM alert_server;
GRANT ALL ON TABLE client TO alert_server;


--
-- Name: clientgroup; Type: ACL; Schema: public; Owner: alert_server
--

REVOKE ALL ON TABLE clientgroup FROM PUBLIC;
REVOKE ALL ON TABLE clientgroup FROM alert_server;
GRANT ALL ON TABLE clientgroup TO alert_server;


--
-- Name: clientgroupmember; Type: ACL; Schema: public; Owner: alert_server
--

REVOKE ALL ON TABLE clientgroupmember FROM PUBLIC;
REVOKE ALL ON TABLE clientgroupmember FROM alert_server;
GRANT ALL ON TABLE clientgroupmember TO alert_server;


--
-- PostgreSQL database dump complete
--

