-- Generator : SpinalHDL v1.12.3    git head : 591e64062329e5e2e2b81f4d52422948053edb97
-- Component : StreamLoopback
-- Git hash  : 888da3e7fe74263a760c6524bc13ce8e6d932133

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

package pkg_enum is

end pkg_enum;

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package pkg_scala2hdl is
  function pkg_extract (that : std_logic_vector; bitId : integer) return std_logic;
  function pkg_extract (that : std_logic_vector; base : unsigned; size : integer) return std_logic_vector;
  function pkg_cat (a : std_logic_vector; b : std_logic_vector) return std_logic_vector;
  function pkg_not (value : std_logic_vector) return std_logic_vector;
  function pkg_extract (that : unsigned; bitId : integer) return std_logic;
  function pkg_extract (that : unsigned; base : unsigned; size : integer) return unsigned;
  function pkg_cat (a : unsigned; b : unsigned) return unsigned;
  function pkg_not (value : unsigned) return unsigned;
  function pkg_extract (that : signed; bitId : integer) return std_logic;
  function pkg_extract (that : signed; base : unsigned; size : integer) return signed;
  function pkg_cat (a : signed; b : signed) return signed;
  function pkg_not (value : signed) return signed;

  function pkg_mux (sel : std_logic; one : std_logic; zero : std_logic) return std_logic;
  function pkg_mux (sel : std_logic; one : std_logic_vector; zero : std_logic_vector) return std_logic_vector;
  function pkg_mux (sel : std_logic; one : unsigned; zero : unsigned) return unsigned;
  function pkg_mux (sel : std_logic; one : signed; zero : signed) return signed;

  function pkg_toStdLogic (value : boolean) return std_logic;
  function pkg_toStdLogicVector (value : std_logic) return std_logic_vector;
  function pkg_toUnsigned (value : std_logic) return unsigned;
  function pkg_toSigned (value : std_logic) return signed;
  function pkg_stdLogicVector (lit : std_logic_vector) return std_logic_vector;
  function pkg_unsigned (lit : unsigned) return unsigned;
  function pkg_signed (lit : signed) return signed;

  function pkg_resize (that : std_logic_vector; width : integer) return std_logic_vector;
  function pkg_resize (that : unsigned; width : integer) return unsigned;
  function pkg_resize (that : signed; width : integer) return signed;

  function pkg_extract (that : std_logic_vector; high : integer; low : integer) return std_logic_vector;
  function pkg_extract (that : unsigned; high : integer; low : integer) return unsigned;
  function pkg_extract (that : signed; high : integer; low : integer) return signed;

  function pkg_shiftRight (that : std_logic_vector; size : natural) return std_logic_vector;
  function pkg_shiftRight (that : std_logic_vector; size : unsigned) return std_logic_vector;
  function pkg_shiftLeft (that : std_logic_vector; size : natural) return std_logic_vector;
  function pkg_shiftLeft (that : std_logic_vector; size : unsigned) return std_logic_vector;

  function pkg_shiftRight (that : unsigned; size : natural) return unsigned;
  function pkg_shiftRight (that : unsigned; size : unsigned) return unsigned;
  function pkg_shiftLeft (that : unsigned; size : natural) return unsigned;
  function pkg_shiftLeft (that : unsigned; size : unsigned) return unsigned;

  function pkg_shiftRight (that : signed; size : natural) return signed;
  function pkg_shiftRight (that : signed; size : unsigned) return signed;
  function pkg_shiftLeft (that : signed; size : natural) return signed;
  function pkg_shiftLeft (that : signed; size : unsigned; w : integer) return signed;

  function pkg_rotateLeft (that : std_logic_vector; size : unsigned) return std_logic_vector;

  function pkg_toString (that : std_logic_vector) return string;
  function pkg_toString (that : unsigned) return string;
  function pkg_toString (that : signed) return string;
end  pkg_scala2hdl;

package body pkg_scala2hdl is
  function pkg_extract (that : std_logic_vector; bitId : integer) return std_logic is
    alias temp : std_logic_vector(that'length-1 downto 0) is that;
  begin
    if bitId >= temp'length then
      return 'U';
    end if;
    return temp(bitId);
  end pkg_extract;

  function pkg_extract (that : std_logic_vector; base : unsigned; size : integer) return std_logic_vector is
    alias temp : std_logic_vector(that'length-1 downto 0) is that;    constant elementCount : integer := temp'length - size + 1;
    type tableType is array (0 to elementCount-1) of std_logic_vector(size-1 downto 0);
    variable table : tableType;
  begin
    for i in 0 to elementCount-1 loop
      table(i) := temp(i + size - 1 downto i);
    end loop;
    if base + size >= elementCount then
      return (size-1 downto 0 => 'U');
    end if;
    return table(to_integer(base));
  end pkg_extract;

  function pkg_cat (a : std_logic_vector; b : std_logic_vector) return std_logic_vector is
    variable cat : std_logic_vector(a'length + b'length-1 downto 0);
  begin
    cat := a & b;
    return cat;
  end pkg_cat;

  function pkg_not (value : std_logic_vector) return std_logic_vector is
    variable ret : std_logic_vector(value'length-1 downto 0);
  begin
    ret := not value;
    return ret;
  end pkg_not;

  function pkg_extract (that : unsigned; bitId : integer) return std_logic is
    alias temp : unsigned(that'length-1 downto 0) is that;
  begin
    if bitId >= temp'length then
      return 'U';
    end if;
    return temp(bitId);
  end pkg_extract;

  function pkg_extract (that : unsigned; base : unsigned; size : integer) return unsigned is
    alias temp : unsigned(that'length-1 downto 0) is that;    constant elementCount : integer := temp'length - size + 1;
    type tableType is array (0 to elementCount-1) of unsigned(size-1 downto 0);
    variable table : tableType;
  begin
    for i in 0 to elementCount-1 loop
      table(i) := temp(i + size - 1 downto i);
    end loop;
    if base + size >= elementCount then
      return (size-1 downto 0 => 'U');
    end if;
    return table(to_integer(base));
  end pkg_extract;

  function pkg_cat (a : unsigned; b : unsigned) return unsigned is
    variable cat : unsigned(a'length + b'length-1 downto 0);
  begin
    cat := a & b;
    return cat;
  end pkg_cat;

  function pkg_not (value : unsigned) return unsigned is
    variable ret : unsigned(value'length-1 downto 0);
  begin
    ret := not value;
    return ret;
  end pkg_not;

  function pkg_extract (that : signed; bitId : integer) return std_logic is
    alias temp : signed(that'length-1 downto 0) is that;
  begin
    if bitId >= temp'length then
      return 'U';
    end if;
    return temp(bitId);
  end pkg_extract;

  function pkg_extract (that : signed; base : unsigned; size : integer) return signed is
    alias temp : signed(that'length-1 downto 0) is that;    constant elementCount : integer := temp'length - size + 1;
    type tableType is array (0 to elementCount-1) of signed(size-1 downto 0);
    variable table : tableType;
  begin
    for i in 0 to elementCount-1 loop
      table(i) := temp(i + size - 1 downto i);
    end loop;
    if base + size >= elementCount then
      return (size-1 downto 0 => 'U');
    end if;
    return table(to_integer(base));
  end pkg_extract;

  function pkg_cat (a : signed; b : signed) return signed is
    variable cat : signed(a'length + b'length-1 downto 0);
  begin
    cat := a & b;
    return cat;
  end pkg_cat;

  function pkg_not (value : signed) return signed is
    variable ret : signed(value'length-1 downto 0);
  begin
    ret := not value;
    return ret;
  end pkg_not;


  -- unsigned shifts
  function pkg_shiftRight (that : unsigned; size : natural) return unsigned is
    variable ret : unsigned(that'length-1 downto 0);
  begin
    if size >= that'length then
      return "";
    else
      ret := shift_right(that,size);
      return ret(that'length-1-size downto 0);
    end if;
  end pkg_shiftRight;

  function pkg_shiftRight (that : unsigned; size : unsigned) return unsigned is
    variable ret : unsigned(that'length-1 downto 0);
  begin
    ret := shift_right(that,to_integer(size));
    return ret;
  end pkg_shiftRight;

  function pkg_shiftLeft (that : unsigned; size : natural) return unsigned is
  begin
    return shift_left(resize(that,that'length + size),size);
  end pkg_shiftLeft;

  function pkg_shiftLeft (that : unsigned; size : unsigned) return unsigned is
  begin
    return shift_left(resize(that,that'length + 2**size'length - 1),to_integer(size));
  end pkg_shiftLeft;

  -- std_logic_vector shifts
  function pkg_shiftRight (that : std_logic_vector; size : natural) return std_logic_vector is
  begin
    return std_logic_vector(pkg_shiftRight(unsigned(that),size));
  end pkg_shiftRight;

  function pkg_shiftRight (that : std_logic_vector; size : unsigned) return std_logic_vector is
  begin
    return std_logic_vector(pkg_shiftRight(unsigned(that),size));
  end pkg_shiftRight;

  function pkg_shiftLeft (that : std_logic_vector; size : natural) return std_logic_vector is
  begin
    return std_logic_vector(pkg_shiftLeft(unsigned(that),size));
  end pkg_shiftLeft;

  function pkg_shiftLeft (that : std_logic_vector; size : unsigned) return std_logic_vector is
  begin
    return std_logic_vector(pkg_shiftLeft(unsigned(that),size));
  end pkg_shiftLeft;

  -- signed shifts
  function pkg_shiftRight (that : signed; size : natural) return signed is
  begin
    return signed(pkg_shiftRight(unsigned(that),size));
  end pkg_shiftRight;

  function pkg_shiftRight (that : signed; size : unsigned) return signed is
  begin
    return shift_right(that,to_integer(size));
  end pkg_shiftRight;

  function pkg_shiftLeft (that : signed; size : natural) return signed is
  begin
    return signed(pkg_shiftLeft(unsigned(that),size));
  end pkg_shiftLeft;

  function pkg_shiftLeft (that : signed; size : unsigned; w : integer) return signed is
  begin
    return shift_left(resize(that,w),to_integer(size));
  end pkg_shiftLeft;

  function pkg_rotateLeft (that : std_logic_vector; size : unsigned) return std_logic_vector is
  begin
    return std_logic_vector(rotate_left(unsigned(that),to_integer(size)));
  end pkg_rotateLeft;

  function pkg_extract (that : std_logic_vector; high : integer; low : integer) return std_logic_vector is
    alias temp : std_logic_vector(that'length-1 downto 0) is that;
  begin
    return temp(high downto low);
  end pkg_extract;

  function pkg_extract (that : unsigned; high : integer; low : integer) return unsigned is
    alias temp : unsigned(that'length-1 downto 0) is that;
  begin
    return temp(high downto low);
  end pkg_extract;

  function pkg_extract (that : signed; high : integer; low : integer) return signed is
    alias temp : signed(that'length-1 downto 0) is that;
  begin
    return temp(high downto low);
  end pkg_extract;

  function pkg_mux (sel : std_logic; one : std_logic; zero : std_logic) return std_logic is
  begin
    if sel = '1' then
      return one;
    else
      return zero;
    end if;
  end pkg_mux;

  function pkg_mux (sel : std_logic; one : std_logic_vector; zero : std_logic_vector) return std_logic_vector is
    variable ret : std_logic_vector(zero'range);
  begin
    if sel = '1' then
      ret := one;
    else
      ret := zero;
    end if;
    return ret;
  end pkg_mux;

  function pkg_mux (sel : std_logic; one : unsigned; zero : unsigned) return unsigned is
    variable ret : unsigned(zero'range);
  begin
    if sel = '1' then
      ret := one;
    else
      ret := zero;
    end if;
    return ret;
  end pkg_mux;

  function pkg_mux (sel : std_logic; one : signed; zero : signed) return signed is
    variable ret : signed(zero'range);
  begin
    if sel = '1' then
      ret := one;
    else
      ret := zero;
    end if;
    return ret;
  end pkg_mux;

  function pkg_toStdLogic (value : boolean) return std_logic is
  begin
    if value = true then
      return '1';
    else
      return '0';
    end if;
  end pkg_toStdLogic;

  function pkg_toStdLogicVector (value : std_logic) return std_logic_vector is
    variable ret : std_logic_vector(0 downto 0);
  begin
    ret(0) := value;
    return ret;
  end pkg_toStdLogicVector;

  function pkg_toUnsigned (value : std_logic) return unsigned is
    variable ret : unsigned(0 downto 0);
  begin
    ret(0) := value;
    return ret;
  end pkg_toUnsigned;

  function pkg_toSigned (value : std_logic) return signed is
    variable ret : signed(0 downto 0);
  begin
    ret(0) := value;
    return ret;
  end pkg_toSigned;

  function pkg_stdLogicVector (lit : std_logic_vector) return std_logic_vector is
    alias ret : std_logic_vector(lit'length-1 downto 0) is lit;
  begin
    return std_logic_vector(ret);
  end pkg_stdLogicVector;

  function pkg_unsigned (lit : unsigned) return unsigned is
    alias ret : unsigned(lit'length-1 downto 0) is lit;
  begin
    return unsigned(ret);
  end pkg_unsigned;

  function pkg_signed (lit : signed) return signed is
    alias ret : signed(lit'length-1 downto 0) is lit;
  begin
    return signed(ret);
  end pkg_signed;

  function pkg_resize (that : std_logic_vector; width : integer) return std_logic_vector is
  begin
    return std_logic_vector(resize(unsigned(that),width));
  end pkg_resize;

  function pkg_resize (that : unsigned; width : integer) return unsigned is
    variable ret : unsigned(width-1 downto 0);
  begin
    if that'length = 0 then
       ret := (others => '0');
    else
       ret := resize(that,width);
    end if;
    return ret;
  end pkg_resize;
  function pkg_resize (that : signed; width : integer) return signed is
    alias temp : signed(that'length-1 downto 0) is that;
    variable ret : signed(width-1 downto 0);
  begin
    if temp'length = 0 then
       ret := (others => '0');
    elsif temp'length >= width then
       ret := temp(width-1 downto 0);
    else
       ret := resize(temp,width);
    end if;
    return ret;
  end pkg_resize;

  function pkg_toString (that : std_logic_vector) return string is
    variable ret : string((that'length-1)/4 downto 0);
    constant chars : string := "0123456789abcdef";
    variable left : natural;
  begin
    for i in ret'range loop
      left := i*4+3;
      if left > that'left then
        left := that'left;
      end if;
      ret(i) := chars(to_integer(unsigned(that(left downto i*4)))+1);
    end loop;
    return "x" & '"' & ret & '"';
  end pkg_toString;
  function pkg_toString (that : unsigned) return string is
  begin
    if that > 0 then
      return pkg_toString(that / 10) & integer'image(to_integer(that mod 10));
    else
      return "";
    end if;
  end pkg_toString;
  function pkg_toString (that : signed) return string is
  begin
    if that < 0 then
      return "-" & pkg_toString(0 - pkg_resize(that, that'length + 1));
    elsif that > 0 then
      return pkg_toString(that / 10) & integer'image(to_integer(that mod 10));
    else
      return "";
    end if;
  end pkg_toString;
end pkg_scala2hdl;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pkg_scala2hdl.all;
use work.all;
use work.pkg_enum.all;


entity StreamFifo is
  port(
    io_push_valid : in std_logic;
    io_push_ready : out std_logic;
    io_push_payload : in std_logic_vector(255 downto 0);
    io_pop_valid : out std_logic;
    io_pop_ready : in std_logic;
    io_pop_payload : out std_logic_vector(255 downto 0);
    io_flush : in std_logic;
    io_occupancy : out unsigned(9 downto 0);
    io_availability : out unsigned(9 downto 0);
    clk : in std_logic;
    resetn : in std_logic
  );

end StreamFifo;

architecture arch of StreamFifo is
  signal logic_ram_spinal_port1 : std_logic_vector(255 downto 0);
  signal io_push_ready_read_buffer : std_logic;

  signal zz_1 : std_logic;
  signal logic_ptr_doPush : std_logic;
  signal logic_ptr_doPop : std_logic;
  signal logic_ptr_full : std_logic;
  signal logic_ptr_empty : std_logic;
  signal logic_ptr_push : unsigned(9 downto 0);
  signal logic_ptr_pop : unsigned(9 downto 0);
  signal logic_ptr_occupancy : unsigned(9 downto 0);
  signal logic_ptr_popOnIo : unsigned(9 downto 0);
  signal when_Stream_l1455 : std_logic;
  signal logic_ptr_wentUp : std_logic;
  signal io_push_fire : std_logic;
  signal logic_push_onRam_write_valid : std_logic;
  signal logic_push_onRam_write_payload_address : unsigned(8 downto 0);
  signal logic_push_onRam_write_payload_data : std_logic_vector(255 downto 0);
  signal logic_pop_addressGen_valid : std_logic;
  signal logic_pop_addressGen_ready : std_logic;
  signal logic_pop_addressGen_payload : unsigned(8 downto 0);
  signal logic_pop_addressGen_fire : std_logic;
  signal logic_pop_sync_readArbitation_valid : std_logic;
  signal logic_pop_sync_readArbitation_ready : std_logic;
  signal logic_pop_sync_readArbitation_payload : unsigned(8 downto 0);
  signal logic_pop_addressGen_rValid : std_logic;
  signal logic_pop_addressGen_rData : unsigned(8 downto 0);
  signal when_Stream_l477 : std_logic;
  signal logic_pop_sync_readPort_cmd_valid : std_logic;
  signal logic_pop_sync_readPort_cmd_payload : unsigned(8 downto 0);
  signal logic_pop_sync_readPort_rsp : std_logic_vector(255 downto 0);
  signal logic_pop_addressGen_toFlowFire_valid : std_logic;
  signal logic_pop_addressGen_toFlowFire_payload : unsigned(8 downto 0);
  signal logic_pop_sync_readArbitation_translated_valid : std_logic;
  signal logic_pop_sync_readArbitation_translated_ready : std_logic;
  signal logic_pop_sync_readArbitation_translated_payload : std_logic_vector(255 downto 0);
  signal logic_pop_sync_readArbitation_fire : std_logic;
  signal logic_pop_sync_popReg : unsigned(9 downto 0);
  type logic_ram_type is array (0 to 511) of std_logic_vector(255 downto 0);
  signal logic_ram : logic_ram_type;
begin
  io_push_ready <= io_push_ready_read_buffer;
  process(clk)
  begin
    if rising_edge(clk) then
      if zz_1 = '1' then
      logic_ram(to_integer(logic_push_onRam_write_payload_address)) <= logic_push_onRam_write_payload_data;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if logic_pop_sync_readPort_cmd_valid = '1' then
        logic_ram_spinal_port1 <= logic_ram(to_integer(logic_pop_sync_readPort_cmd_payload));
      end if;
    end if;
  end process;

  process(logic_push_onRam_write_valid)
  begin
    zz_1 <= pkg_toStdLogic(false);
    if logic_push_onRam_write_valid = '1' then
      zz_1 <= pkg_toStdLogic(true);
    end if;
  end process;

  when_Stream_l1455 <= pkg_toStdLogic(logic_ptr_doPush /= logic_ptr_doPop);
  logic_ptr_full <= pkg_toStdLogic(((logic_ptr_push xor logic_ptr_popOnIo) xor pkg_unsigned("1000000000")) = pkg_unsigned("0000000000"));
  logic_ptr_empty <= pkg_toStdLogic(logic_ptr_push = logic_ptr_pop);
  logic_ptr_occupancy <= (logic_ptr_push - logic_ptr_popOnIo);
  io_push_ready_read_buffer <= (not logic_ptr_full);
  io_push_fire <= (io_push_valid and io_push_ready_read_buffer);
  logic_ptr_doPush <= io_push_fire;
  logic_push_onRam_write_valid <= io_push_fire;
  logic_push_onRam_write_payload_address <= pkg_resize(logic_ptr_push,9);
  logic_push_onRam_write_payload_data <= io_push_payload;
  logic_pop_addressGen_valid <= (not logic_ptr_empty);
  logic_pop_addressGen_payload <= pkg_resize(logic_ptr_pop,9);
  logic_pop_addressGen_fire <= (logic_pop_addressGen_valid and logic_pop_addressGen_ready);
  logic_ptr_doPop <= logic_pop_addressGen_fire;
  process(logic_pop_sync_readArbitation_ready,when_Stream_l477)
  begin
    logic_pop_addressGen_ready <= logic_pop_sync_readArbitation_ready;
    if when_Stream_l477 = '1' then
      logic_pop_addressGen_ready <= pkg_toStdLogic(true);
    end if;
  end process;

  when_Stream_l477 <= (not logic_pop_sync_readArbitation_valid);
  logic_pop_sync_readArbitation_valid <= logic_pop_addressGen_rValid;
  logic_pop_sync_readArbitation_payload <= logic_pop_addressGen_rData;
  logic_pop_sync_readPort_rsp <= logic_ram_spinal_port1;
  logic_pop_addressGen_toFlowFire_valid <= logic_pop_addressGen_fire;
  logic_pop_addressGen_toFlowFire_payload <= logic_pop_addressGen_payload;
  logic_pop_sync_readPort_cmd_valid <= logic_pop_addressGen_toFlowFire_valid;
  logic_pop_sync_readPort_cmd_payload <= logic_pop_addressGen_toFlowFire_payload;
  logic_pop_sync_readArbitation_translated_valid <= logic_pop_sync_readArbitation_valid;
  logic_pop_sync_readArbitation_ready <= logic_pop_sync_readArbitation_translated_ready;
  logic_pop_sync_readArbitation_translated_payload <= logic_pop_sync_readPort_rsp;
  io_pop_valid <= logic_pop_sync_readArbitation_translated_valid;
  logic_pop_sync_readArbitation_translated_ready <= io_pop_ready;
  io_pop_payload <= logic_pop_sync_readArbitation_translated_payload;
  logic_pop_sync_readArbitation_fire <= (logic_pop_sync_readArbitation_valid and logic_pop_sync_readArbitation_ready);
  logic_ptr_popOnIo <= logic_pop_sync_popReg;
  io_occupancy <= logic_ptr_occupancy;
  io_availability <= (pkg_unsigned("1000000000") - logic_ptr_occupancy);
  process(clk, resetn)
  begin
    if resetn = '0' then
      logic_ptr_push <= pkg_unsigned("0000000000");
      logic_ptr_pop <= pkg_unsigned("0000000000");
      logic_ptr_wentUp <= pkg_toStdLogic(false);
      logic_pop_addressGen_rValid <= pkg_toStdLogic(false);
      logic_pop_sync_popReg <= pkg_unsigned("0000000000");
    elsif rising_edge(clk) then
      if when_Stream_l1455 = '1' then
        logic_ptr_wentUp <= logic_ptr_doPush;
      end if;
      if io_flush = '1' then
        logic_ptr_wentUp <= pkg_toStdLogic(false);
      end if;
      if logic_ptr_doPush = '1' then
        logic_ptr_push <= (logic_ptr_push + pkg_unsigned("0000000001"));
      end if;
      if logic_ptr_doPop = '1' then
        logic_ptr_pop <= (logic_ptr_pop + pkg_unsigned("0000000001"));
      end if;
      if io_flush = '1' then
        logic_ptr_push <= pkg_unsigned("0000000000");
        logic_ptr_pop <= pkg_unsigned("0000000000");
      end if;
      if logic_pop_addressGen_ready = '1' then
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end if;
      if io_flush = '1' then
        logic_pop_addressGen_rValid <= pkg_toStdLogic(false);
      end if;
      if logic_pop_sync_readArbitation_fire = '1' then
        logic_pop_sync_popReg <= logic_ptr_pop;
      end if;
      if io_flush = '1' then
        logic_pop_sync_popReg <= pkg_unsigned("0000000000");
      end if;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if logic_pop_addressGen_ready = '1' then
        logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
      end if;
    end if;
  end process;

end arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pkg_scala2hdl.all;
use work.all;
use work.pkg_enum.all;


entity StreamLoopback is
  port(
    io_dataIn_valid : in std_logic;
    io_dataIn_ready : out std_logic;
    io_dataIn_payload : in std_logic_vector(255 downto 0);
    io_dataOut_valid : out std_logic;
    io_dataOut_ready : in std_logic;
    io_dataOut_payload : out std_logic_vector(255 downto 0);
    clk : in std_logic;
    resetn : in std_logic
  );

end StreamLoopback;

architecture arch of StreamLoopback is
  signal fifo_io_push_valid : std_logic;
  signal io_dataIn_ready_read_buffer : std_logic;
  signal io_dataOut_valid_read_buffer : std_logic;
  signal fifo_io_push_ready : std_logic;
  signal fifo_io_pop_valid : std_logic;
  signal fifo_io_pop_payload : std_logic_vector(255 downto 0);
  signal fifo_io_occupancy : unsigned(9 downto 0);
  signal fifo_io_availability : unsigned(9 downto 0);

  signal samplesReceived : unsigned(31 downto 0);
  signal samplesSent : unsigned(31 downto 0);
  signal throttleCounter : unsigned(31 downto 0);
  signal isReady : std_logic;
  signal io_dataIn_fire : std_logic;
  signal when_StreamLoopback_l56 : std_logic;
  signal io_dataOut_fire : std_logic;
begin
  io_dataIn_ready <= io_dataIn_ready_read_buffer;
  io_dataOut_valid <= io_dataOut_valid_read_buffer;
  fifo : entity work.StreamFifo
    port map ( 
      io_push_valid => fifo_io_push_valid,
      io_push_ready => fifo_io_push_ready,
      io_push_payload => io_dataIn_payload,
      io_pop_valid => fifo_io_pop_valid,
      io_pop_ready => io_dataOut_ready,
      io_pop_payload => fifo_io_pop_payload,
      io_flush => pkg_toStdLogic(false),
      io_occupancy => fifo_io_occupancy,
      io_availability => fifo_io_availability,
      clk => clk,
      resetn => resetn 
    );
  isReady <= pkg_toStdLogic(throttleCounter = pkg_unsigned("00000000000000000000000000000000"));
  io_dataIn_ready_read_buffer <= (isReady and fifo_io_push_ready);
  fifo_io_push_valid <= (io_dataIn_valid and isReady);
  io_dataIn_fire <= (io_dataIn_valid and io_dataIn_ready_read_buffer);
  when_StreamLoopback_l56 <= pkg_toStdLogic(throttleCounter /= pkg_unsigned("00000000000000000000000000000000"));
  io_dataOut_valid_read_buffer <= fifo_io_pop_valid;
  io_dataOut_payload <= fifo_io_pop_payload;
  io_dataOut_fire <= (io_dataOut_valid_read_buffer and io_dataOut_ready);
  process(clk, resetn)
  begin
    if resetn = '0' then
      samplesReceived <= pkg_unsigned("00000000000000000000000000000000");
      samplesSent <= pkg_unsigned("00000000000000000000000000000000");
      throttleCounter <= pkg_unsigned("00000000000000000000000000000000");
    elsif rising_edge(clk) then
      if io_dataIn_fire = '1' then
        samplesReceived <= (samplesReceived + pkg_unsigned("00000000000000000000000000000001"));
        throttleCounter <= pkg_unsigned("00000000000000000000000000000000");
      else
        if when_StreamLoopback_l56 = '1' then
          throttleCounter <= (throttleCounter - pkg_unsigned("00000000000000000000000000000001"));
        end if;
      end if;
      if io_dataOut_fire = '1' then
        samplesSent <= (samplesSent + pkg_unsigned("00000000000000000000000000000001"));
      end if;
    end if;
  end process;

end arch;

