-- 1. Create the bible table
CREATE TABLE sleep (
    sleep_id RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    sleep varchar2(4000) not null,
    date_slept               TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9),
    CONSTRAINT uq_bible UNIQUE ( sleep ),

    -- Additional columns for note and dates
    note                       VARCHAR2(4000),  -- General-purpose note field
    date_created               TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated               TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated    TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated, date_created) ) VIRTUAL
);


-- Trigger to update date_updated for operating_system
CREATE OR REPLACE TRIGGER trg_set_date_updated_sleep
BEFORE UPDATE ON sleep
FOR EACH ROW
BEGIN
    :NEW.date_updated := systimestamp;
END;
/