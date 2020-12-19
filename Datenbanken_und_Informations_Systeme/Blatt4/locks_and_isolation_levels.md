# Lock intensions:
NS: The lock owner and all concurrent applications can read, but not update, the locked row. This lock is acquired on rows of a table, instead of an S lock, where the isolation level of the application is either RS or CS.

IS: The lock owner can read data in the locked table, but cannot update this data. Other applications can read or update the table.

S: The lock owner and all concurrent applications can read, but not update, the locked data.

SIX: The lock owner can read and update data. Other concurrent applications can read the table.


Isolation levels:

RR: Repeatable read
- During Unit of Work no other application is allowed to modify the result set
- Lost updates, access to uncommitted data, non-repeatable reads, and phantom reads are not possible. 
- Other applications can read as often as possible without changes during UoW until it completes.

RS: Read stabiliy
- No row of UoW can be modified
- No modified row of other Transaction can be read until commited 
- Phantom reads might occur

CS:  Cursor stability
- Lock on row it reads
- If data has been modified, lock on this row is held
- Access to uncommitted data from other transactions is not possible
