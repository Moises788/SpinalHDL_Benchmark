-- Generator : SpinalHDL v1.12.3    git head : 591e64062329e5e2e2b81f4d52422948053edb97
-- Component : StreamToDdrPynq
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


entity BufferCC is
  port(
    io_dataIn : in std_logic_vector(10 downto 0);
    io_dataOut : out std_logic_vector(10 downto 0);
    io_streamClk : in std_logic;
    io_streamReset : in std_logic
  );

end BufferCC;

architecture arch of BufferCC is
  attribute altera_attribute : string;
  attribute async_reg : string;

  signal buffers_0 : std_logic_vector(10 downto 0);
  attribute async_reg of buffers_0 : signal is "true";
  attribute altera_attribute of buffers_0 : signal is "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW";
  signal buffers_1 : std_logic_vector(10 downto 0);
  attribute async_reg of buffers_1 : signal is "true";
begin
  io_dataOut <= buffers_1;
  process(io_streamClk, io_streamReset)
  begin
    if io_streamReset = '0' then
      buffers_0 <= pkg_stdLogicVector("00000000000");
      buffers_1 <= pkg_stdLogicVector("00000000000");
    elsif rising_edge(io_streamClk) then
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
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


entity BufferCC_1 is
  port(
    io_dataIn : in std_logic;
    io_dataOut : out std_logic;
    clk : in std_logic;
    io_streamReset : in std_logic
  );

end BufferCC_1;

architecture arch of BufferCC_1 is
  attribute async_reg : string;

  signal buffers_0 : std_logic;
  attribute async_reg of buffers_0 : signal is "true";
  signal buffers_1 : std_logic;
  attribute async_reg of buffers_1 : signal is "true";
begin
  io_dataOut <= buffers_1;
  process(clk, io_streamReset)
  begin
    if io_streamReset = '0' then
      buffers_0 <= pkg_toStdLogic(false);
      buffers_1 <= pkg_toStdLogic(false);
    elsif rising_edge(clk) then
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
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


entity BufferCC_2 is
  port(
    io_dataIn : in std_logic_vector(10 downto 0);
    io_dataOut : out std_logic_vector(10 downto 0);
    clk : in std_logic;
    toplevel_io_streamReset_synchronized : in std_logic
  );

end BufferCC_2;

architecture arch of BufferCC_2 is
  attribute altera_attribute : string;
  attribute async_reg : string;

  signal buffers_0 : std_logic_vector(10 downto 0);
  attribute async_reg of buffers_0 : signal is "true";
  attribute altera_attribute of buffers_0 : signal is "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW";
  signal buffers_1 : std_logic_vector(10 downto 0);
  attribute async_reg of buffers_1 : signal is "true";
begin
  io_dataOut <= buffers_1;
  process(clk, toplevel_io_streamReset_synchronized)
  begin
    if toplevel_io_streamReset_synchronized = '0' then
      buffers_0 <= pkg_stdLogicVector("00000000000");
      buffers_1 <= pkg_stdLogicVector("00000000000");
    elsif rising_edge(clk) then
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
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


entity StreamFifoCC_StreamToDdr_StreamDDR is
  port(
    io_push_valid : in std_logic;
    io_push_ready : out std_logic;
    io_push_payload : in std_logic_vector(255 downto 0);
    io_pop_valid : out std_logic;
    io_pop_ready : in std_logic;
    io_pop_payload : out std_logic_vector(255 downto 0);
    io_pushOccupancy : out unsigned(10 downto 0);
    io_popOccupancy : out unsigned(10 downto 0);
    io_streamClk : in std_logic;
    io_streamReset : in std_logic;
    clk : in std_logic
  );
  attribute keep_hierarchy : string;

end StreamFifoCC_StreamToDdr_StreamDDR;

architecture arch of StreamFifoCC_StreamToDdr_StreamDDR is
  signal ram_spinal_port1 : std_logic_vector(255 downto 0);
  signal io_push_ready_read_buffer : std_logic;
  signal popToPushGray_buffercc_io_dataOut : std_logic_vector(10 downto 0);
  signal toplevel_io_streamReset_asyncAssertSyncDeassert_buffercc_io_dataOut : std_logic;
  signal pushToPopGray_buffercc_io_dataOut : std_logic_vector(10 downto 0);
  signal zz_ram_port : unsigned(9 downto 0);
  signal zz_io_pushOccupancy_10 : std_logic_vector(0 downto 0);
  signal zz_io_pushOccupancy_11 : std_logic_vector(0 downto 0);
  signal zz_io_popOccupancy_10 : std_logic_vector(0 downto 0);
  signal zz_io_popOccupancy_11 : std_logic_vector(0 downto 0);
  attribute keep : boolean;
  attribute syn_keep : boolean;
  attribute altera_attribute : string;

  signal zz_1 : std_logic;
  signal popToPushGray : std_logic_vector(10 downto 0);
  signal pushToPopGray : std_logic_vector(10 downto 0);
  signal pushCC_pushPtr : unsigned(10 downto 0);
  signal pushCC_pushPtrPlus : unsigned(10 downto 0);
  signal io_push_fire : std_logic;
  signal pushCC_pushPtrGray : std_logic_vector(10 downto 0);
  attribute altera_attribute of pushCC_pushPtrGray : signal is "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW";
  signal pushCC_popPtrGray : std_logic_vector(10 downto 0);
  signal pushCC_full : std_logic;
  signal zz_io_pushOccupancy : std_logic;
  signal zz_io_pushOccupancy_1 : std_logic;
  signal zz_io_pushOccupancy_2 : std_logic;
  signal zz_io_pushOccupancy_3 : std_logic;
  signal zz_io_pushOccupancy_4 : std_logic;
  signal zz_io_pushOccupancy_5 : std_logic;
  signal zz_io_pushOccupancy_6 : std_logic;
  signal zz_io_pushOccupancy_7 : std_logic;
  signal zz_io_pushOccupancy_8 : std_logic;
  signal zz_io_pushOccupancy_9 : std_logic;
  signal toplevel_io_streamReset_asyncAssertSyncDeassert : std_logic;
  signal toplevel_io_streamReset_synchronized : std_logic;
  signal popCC_popPtr : unsigned(10 downto 0);
  signal popCC_popPtrPlus : unsigned(10 downto 0);
  attribute keep of popCC_popPtrPlus : signal is true;
  attribute syn_keep of popCC_popPtrPlus : signal is true;
  signal popCC_popPtrGray : std_logic_vector(10 downto 0);
  signal popCC_pushPtrGray : std_logic_vector(10 downto 0);
  signal popCC_addressGen_valid : std_logic;
  signal popCC_addressGen_ready : std_logic;
  signal popCC_addressGen_payload : unsigned(9 downto 0);
  signal popCC_empty : std_logic;
  signal popCC_addressGen_fire : std_logic;
  signal popCC_readArbitation_valid : std_logic;
  signal popCC_readArbitation_ready : std_logic;
  signal popCC_readArbitation_payload : unsigned(9 downto 0);
  signal popCC_addressGen_rValid : std_logic;
  signal popCC_addressGen_rData : unsigned(9 downto 0);
  signal when_Stream_l477 : std_logic;
  signal popCC_readPort_cmd_valid : std_logic;
  signal popCC_readPort_cmd_payload : unsigned(9 downto 0);
  signal popCC_readPort_rsp : std_logic_vector(255 downto 0);
  signal popCC_addressGen_toFlowFire_valid : std_logic;
  signal popCC_addressGen_toFlowFire_payload : unsigned(9 downto 0);
  signal popCC_readArbitation_translated_valid : std_logic;
  signal popCC_readArbitation_translated_ready : std_logic;
  signal popCC_readArbitation_translated_payload : std_logic_vector(255 downto 0);
  signal popCC_readArbitation_fire : std_logic;
  signal popCC_ptrToPush : std_logic_vector(10 downto 0);
  attribute altera_attribute of popCC_ptrToPush : signal is "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW";
  signal popCC_ptrToOccupancy : unsigned(10 downto 0);
  signal zz_io_popOccupancy : std_logic;
  signal zz_io_popOccupancy_1 : std_logic;
  signal zz_io_popOccupancy_2 : std_logic;
  signal zz_io_popOccupancy_3 : std_logic;
  signal zz_io_popOccupancy_4 : std_logic;
  signal zz_io_popOccupancy_5 : std_logic;
  signal zz_io_popOccupancy_6 : std_logic;
  signal zz_io_popOccupancy_7 : std_logic;
  signal zz_io_popOccupancy_8 : std_logic;
  signal zz_io_popOccupancy_9 : std_logic;
  type ram_type is array (0 to 1023) of std_logic_vector(255 downto 0);
  signal ram : ram_type;
  attribute keep_hierarchy of popToPushGray_buffercc : label is "TRUE";
  attribute keep_hierarchy of toplevel_io_streamReset_asyncAssertSyncDeassert_buffercc : label is "TRUE";
  attribute keep_hierarchy of pushToPopGray_buffercc : label is "TRUE";
begin
  io_push_ready <= io_push_ready_read_buffer;
  zz_ram_port <= pkg_resize(pushCC_pushPtr,10);
  zz_io_pushOccupancy_10 <= pkg_toStdLogicVector(zz_io_pushOccupancy);
  zz_io_pushOccupancy_11 <= pkg_toStdLogicVector((pkg_extract(pushCC_popPtrGray,0) xor zz_io_pushOccupancy));
  zz_io_popOccupancy_10 <= pkg_toStdLogicVector(zz_io_popOccupancy);
  zz_io_popOccupancy_11 <= pkg_toStdLogicVector((pkg_extract(popCC_pushPtrGray,0) xor zz_io_popOccupancy));
  process(io_streamClk)
  begin
    if rising_edge(io_streamClk) then
      if zz_1 = '1' then
      ram(to_integer(zz_ram_port)) <= io_push_payload;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if popCC_readPort_cmd_valid = '1' then
        ram_spinal_port1 <= ram(to_integer(popCC_readPort_cmd_payload));
      end if;
    end if;
  end process;

  popToPushGray_buffercc : entity work.BufferCC
    port map ( 
      io_dataIn => popToPushGray,
      io_dataOut => popToPushGray_buffercc_io_dataOut,
      io_streamClk => io_streamClk,
      io_streamReset => io_streamReset 
    );
  toplevel_io_streamReset_asyncAssertSyncDeassert_buffercc : entity work.BufferCC_1
    port map ( 
      io_dataIn => toplevel_io_streamReset_asyncAssertSyncDeassert,
      io_dataOut => toplevel_io_streamReset_asyncAssertSyncDeassert_buffercc_io_dataOut,
      clk => clk,
      io_streamReset => io_streamReset 
    );
  pushToPopGray_buffercc : entity work.BufferCC_2
    port map ( 
      io_dataIn => pushToPopGray,
      io_dataOut => pushToPopGray_buffercc_io_dataOut,
      clk => clk,
      toplevel_io_streamReset_synchronized => toplevel_io_streamReset_synchronized 
    );
  process(io_push_fire)
  begin
    zz_1 <= pkg_toStdLogic(false);
    if io_push_fire = '1' then
      zz_1 <= pkg_toStdLogic(true);
    end if;
  end process;

  pushCC_pushPtrPlus <= (pushCC_pushPtr + pkg_unsigned("00000000001"));
  io_push_fire <= (io_push_valid and io_push_ready_read_buffer);
  pushCC_popPtrGray <= popToPushGray_buffercc_io_dataOut;
  pushCC_full <= (pkg_toStdLogic(pkg_extract(pushCC_pushPtrGray,10,9) = pkg_not(pkg_extract(pushCC_popPtrGray,10,9))) and pkg_toStdLogic(pkg_extract(pushCC_pushPtrGray,8,0) = pkg_extract(pushCC_popPtrGray,8,0)));
  io_push_ready_read_buffer <= (not pushCC_full);
  zz_io_pushOccupancy <= (pkg_extract(pushCC_popPtrGray,1) xor zz_io_pushOccupancy_1);
  zz_io_pushOccupancy_1 <= (pkg_extract(pushCC_popPtrGray,2) xor zz_io_pushOccupancy_2);
  zz_io_pushOccupancy_2 <= (pkg_extract(pushCC_popPtrGray,3) xor zz_io_pushOccupancy_3);
  zz_io_pushOccupancy_3 <= (pkg_extract(pushCC_popPtrGray,4) xor zz_io_pushOccupancy_4);
  zz_io_pushOccupancy_4 <= (pkg_extract(pushCC_popPtrGray,5) xor zz_io_pushOccupancy_5);
  zz_io_pushOccupancy_5 <= (pkg_extract(pushCC_popPtrGray,6) xor zz_io_pushOccupancy_6);
  zz_io_pushOccupancy_6 <= (pkg_extract(pushCC_popPtrGray,7) xor zz_io_pushOccupancy_7);
  zz_io_pushOccupancy_7 <= (pkg_extract(pushCC_popPtrGray,8) xor zz_io_pushOccupancy_8);
  zz_io_pushOccupancy_8 <= (pkg_extract(pushCC_popPtrGray,9) xor zz_io_pushOccupancy_9);
  zz_io_pushOccupancy_9 <= pkg_extract(pushCC_popPtrGray,10);
  io_pushOccupancy <= (pushCC_pushPtr - unsigned(pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_9),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_8),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_7),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_6),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_5),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_4),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_3),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_2),pkg_cat(pkg_toStdLogicVector(zz_io_pushOccupancy_1),pkg_cat(zz_io_pushOccupancy_10,zz_io_pushOccupancy_11))))))))))));
  toplevel_io_streamReset_asyncAssertSyncDeassert <= (pkg_toStdLogic(true) xor pkg_toStdLogic(false));
  toplevel_io_streamReset_synchronized <= toplevel_io_streamReset_asyncAssertSyncDeassert_buffercc_io_dataOut;
  popCC_popPtrPlus <= (popCC_popPtr + pkg_unsigned("00000000001"));
  popCC_popPtrGray <= std_logic_vector((pkg_shiftRight(popCC_popPtr,pkg_unsigned("1")) xor popCC_popPtr));
  popCC_pushPtrGray <= pushToPopGray_buffercc_io_dataOut;
  popCC_empty <= pkg_toStdLogic(popCC_popPtrGray = popCC_pushPtrGray);
  popCC_addressGen_valid <= (not popCC_empty);
  popCC_addressGen_payload <= pkg_resize(popCC_popPtr,10);
  popCC_addressGen_fire <= (popCC_addressGen_valid and popCC_addressGen_ready);
  process(popCC_readArbitation_ready,when_Stream_l477)
  begin
    popCC_addressGen_ready <= popCC_readArbitation_ready;
    if when_Stream_l477 = '1' then
      popCC_addressGen_ready <= pkg_toStdLogic(true);
    end if;
  end process;

  when_Stream_l477 <= (not popCC_readArbitation_valid);
  popCC_readArbitation_valid <= popCC_addressGen_rValid;
  popCC_readArbitation_payload <= popCC_addressGen_rData;
  popCC_readPort_rsp <= ram_spinal_port1;
  popCC_addressGen_toFlowFire_valid <= popCC_addressGen_fire;
  popCC_addressGen_toFlowFire_payload <= popCC_addressGen_payload;
  popCC_readPort_cmd_valid <= popCC_addressGen_toFlowFire_valid;
  popCC_readPort_cmd_payload <= popCC_addressGen_toFlowFire_payload;
  popCC_readArbitation_translated_valid <= popCC_readArbitation_valid;
  popCC_readArbitation_ready <= popCC_readArbitation_translated_ready;
  popCC_readArbitation_translated_payload <= popCC_readPort_rsp;
  io_pop_valid <= popCC_readArbitation_translated_valid;
  popCC_readArbitation_translated_ready <= io_pop_ready;
  io_pop_payload <= popCC_readArbitation_translated_payload;
  popCC_readArbitation_fire <= (popCC_readArbitation_valid and popCC_readArbitation_ready);
  zz_io_popOccupancy <= (pkg_extract(popCC_pushPtrGray,1) xor zz_io_popOccupancy_1);
  zz_io_popOccupancy_1 <= (pkg_extract(popCC_pushPtrGray,2) xor zz_io_popOccupancy_2);
  zz_io_popOccupancy_2 <= (pkg_extract(popCC_pushPtrGray,3) xor zz_io_popOccupancy_3);
  zz_io_popOccupancy_3 <= (pkg_extract(popCC_pushPtrGray,4) xor zz_io_popOccupancy_4);
  zz_io_popOccupancy_4 <= (pkg_extract(popCC_pushPtrGray,5) xor zz_io_popOccupancy_5);
  zz_io_popOccupancy_5 <= (pkg_extract(popCC_pushPtrGray,6) xor zz_io_popOccupancy_6);
  zz_io_popOccupancy_6 <= (pkg_extract(popCC_pushPtrGray,7) xor zz_io_popOccupancy_7);
  zz_io_popOccupancy_7 <= (pkg_extract(popCC_pushPtrGray,8) xor zz_io_popOccupancy_8);
  zz_io_popOccupancy_8 <= (pkg_extract(popCC_pushPtrGray,9) xor zz_io_popOccupancy_9);
  zz_io_popOccupancy_9 <= pkg_extract(popCC_pushPtrGray,10);
  io_popOccupancy <= (unsigned(pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_9),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_8),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_7),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_6),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_5),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_4),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_3),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_2),pkg_cat(pkg_toStdLogicVector(zz_io_popOccupancy_1),pkg_cat(zz_io_popOccupancy_10,zz_io_popOccupancy_11))))))))))) - popCC_ptrToOccupancy);
  pushToPopGray <= pushCC_pushPtrGray;
  popToPushGray <= popCC_ptrToPush;
  process(io_streamClk, io_streamReset)
  begin
    if io_streamReset = '0' then
      pushCC_pushPtr <= pkg_unsigned("00000000000");
      pushCC_pushPtrGray <= pkg_stdLogicVector("00000000000");
    elsif rising_edge(io_streamClk) then
      if io_push_fire = '1' then
        pushCC_pushPtrGray <= std_logic_vector((pkg_shiftRight(pushCC_pushPtrPlus,pkg_unsigned("1")) xor pushCC_pushPtrPlus));
      end if;
      if io_push_fire = '1' then
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end if;
    end if;
  end process;

  process(clk, toplevel_io_streamReset_synchronized)
  begin
    if toplevel_io_streamReset_synchronized = '0' then
      popCC_popPtr <= pkg_unsigned("00000000000");
      popCC_addressGen_rValid <= pkg_toStdLogic(false);
      popCC_ptrToPush <= pkg_stdLogicVector("00000000000");
      popCC_ptrToOccupancy <= pkg_unsigned("00000000000");
    elsif rising_edge(clk) then
      if popCC_addressGen_fire = '1' then
        popCC_popPtr <= popCC_popPtrPlus;
      end if;
      if popCC_addressGen_ready = '1' then
        popCC_addressGen_rValid <= popCC_addressGen_valid;
      end if;
      if popCC_readArbitation_fire = '1' then
        popCC_ptrToPush <= popCC_popPtrGray;
      end if;
      if popCC_readArbitation_fire = '1' then
        popCC_ptrToOccupancy <= popCC_popPtr;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if popCC_addressGen_ready = '1' then
        popCC_addressGen_rData <= popCC_addressGen_payload;
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


entity BufferCC_3 is
  port(
    io_dataIn : in std_logic;
    io_dataOut : out std_logic;
    io_streamClk : in std_logic;
    io_streamReset : in std_logic
  );

end BufferCC_3;

architecture arch of BufferCC_3 is
  attribute async_reg : string;

  signal buffers_0 : std_logic;
  attribute async_reg of buffers_0 : signal is "true";
  signal buffers_1 : std_logic;
  attribute async_reg of buffers_1 : signal is "true";
begin
  io_dataOut <= buffers_1;
  process(io_streamClk, io_streamReset)
  begin
    if io_streamReset = '0' then
      buffers_0 <= pkg_toStdLogic(false);
      buffers_1 <= pkg_toStdLogic(false);
    elsif rising_edge(io_streamClk) then
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
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


entity BufferCC_4 is
  port(
    io_dataIn : in std_logic;
    io_dataOut : out std_logic;
    clk : in std_logic;
    resetn : in std_logic
  );

end BufferCC_4;

architecture arch of BufferCC_4 is
  attribute async_reg : string;

  signal buffers_0 : std_logic;
  attribute async_reg of buffers_0 : signal is "true";
  signal buffers_1 : std_logic;
  attribute async_reg of buffers_1 : signal is "true";
begin
  io_dataOut <= buffers_1;
  process(clk, resetn)
  begin
    if resetn = '0' then
      buffers_0 <= pkg_toStdLogic(false);
      buffers_1 <= pkg_toStdLogic(false);
    elsif rising_edge(clk) then
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
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


entity BitGearboxWrite_StreamDDR is
  port(
    io_input_valid : in std_logic;
    io_input_ready : out std_logic;
    io_input_payload : in std_logic_vector(255 downto 0);
    io_output_valid : out std_logic;
    io_output_ready : in std_logic;
    io_output_payload : out std_logic_vector(127 downto 0);
    clk : in std_logic;
    resetn : in std_logic
  );

end BitGearboxWrite_StreamDDR;

architecture arch of BitGearboxWrite_StreamDDR is
  signal io_output_valid_read_buffer : std_logic;
  signal io_input_ready_read_buffer : std_logic;

  signal shiftReg : std_logic_vector(383 downto 0);
  signal bitCount : unsigned(8 downto 0);
  signal io_output_fire : std_logic;
  signal popAmount : unsigned(8 downto 0);
  signal poppedReg : std_logic_vector(383 downto 0);
  signal insertPos : unsigned(8 downto 0);
  signal io_input_fire : std_logic;
begin
  io_output_valid <= io_output_valid_read_buffer;
  io_input_ready <= io_input_ready_read_buffer;
  io_input_ready_read_buffer <= pkg_toStdLogic(bitCount <= pkg_unsigned("010000000"));
  io_output_valid_read_buffer <= pkg_toStdLogic(pkg_unsigned("010000000") <= bitCount);
  io_output_payload <= pkg_extract(shiftReg,127,0);
  io_output_fire <= (io_output_valid_read_buffer and io_output_ready);
  popAmount <= pkg_mux(io_output_fire,pkg_unsigned("010000000"),pkg_unsigned("000000000"));
  poppedReg <= pkg_shiftRight(shiftReg,popAmount);
  insertPos <= (bitCount - popAmount);
  io_input_fire <= (io_input_valid and io_input_ready_read_buffer);
  process(clk, resetn)
  begin
    if resetn = '0' then
      shiftReg <= pkg_stdLogicVector("000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
      bitCount <= pkg_unsigned("000000000");
    elsif rising_edge(clk) then
      if io_input_fire = '1' then
        shiftReg <= (poppedReg or pkg_resize(pkg_shiftLeft(pkg_resize(io_input_payload,384),insertPos),384));
      else
        shiftReg <= poppedReg;
      end if;
      bitCount <= ((bitCount + pkg_mux(io_input_fire,pkg_unsigned("100000000"),pkg_unsigned("000000000"))) - popAmount);
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


entity StreamToDdrPynq is
  port(
    io_streamClk : in std_logic;
    io_streamReset : in std_logic;
    axi_awvalid : out std_logic;
    axi_awready : in std_logic;
    axi_awaddr : out unsigned(31 downto 0);
    axi_awid : out unsigned(3 downto 0);
    axi_awlen : out unsigned(7 downto 0);
    axi_awsize : out unsigned(2 downto 0);
    axi_awburst : out std_logic_vector(1 downto 0);
    axi_awcache : out std_logic_vector(3 downto 0);
    axi_awprot : out std_logic_vector(2 downto 0);
    axi_wvalid : out std_logic;
    axi_wready : in std_logic;
    axi_wdata : out std_logic_vector(127 downto 0);
    axi_wstrb : out std_logic_vector(15 downto 0);
    axi_wlast : out std_logic;
    axi_bvalid : in std_logic;
    axi_bready : out std_logic;
    axi_bid : in unsigned(3 downto 0);
    axi_bresp : in std_logic_vector(1 downto 0);
    axiLite_awvalid : in std_logic;
    axiLite_awready : out std_logic;
    axiLite_awaddr : in unsigned(5 downto 0);
    axiLite_awprot : in std_logic_vector(2 downto 0);
    axiLite_wvalid : in std_logic;
    axiLite_wready : out std_logic;
    axiLite_wdata : in std_logic_vector(31 downto 0);
    axiLite_wstrb : in std_logic_vector(3 downto 0);
    axiLite_bvalid : out std_logic;
    axiLite_bready : in std_logic;
    axiLite_bresp : out std_logic_vector(1 downto 0);
    axiLite_arvalid : in std_logic;
    axiLite_arready : out std_logic;
    axiLite_araddr : in unsigned(5 downto 0);
    axiLite_arprot : in std_logic_vector(2 downto 0);
    axiLite_rvalid : out std_logic;
    axiLite_rready : in std_logic;
    axiLite_rdata : out std_logic_vector(31 downto 0);
    axiLite_rresp : out std_logic_vector(1 downto 0);
    io_dataIn_valid : in std_logic;
    io_dataIn_ready : out std_logic;
    io_dataIn_payload : in std_logic_vector(255 downto 0);
    clk : in std_logic;
    resetn : in std_logic
  );
  attribute keep_hierarchy : string;

end StreamToDdrPynq;

architecture arch of StreamToDdrPynq is
  signal cdcFifo_io_push_valid : std_logic;
  signal gearbox_io_output_ready : std_logic;
  signal axiLite_arready_read_buffer : std_logic;
  signal axiLite_rvalid_read_buffer : std_logic;
  signal axi_awvalid_read_buffer : std_logic;
  signal axi_wvalid_read_buffer : std_logic;
  signal axi_bready_read_buffer : std_logic;
  signal cdcFifo_io_push_ready : std_logic;
  signal cdcFifo_io_pop_valid : std_logic;
  signal cdcFifo_io_pop_payload : std_logic_vector(255 downto 0);
  signal cdcFifo_io_pushOccupancy : unsigned(10 downto 0);
  signal cdcFifo_io_popOccupancy : unsigned(10 downto 0);
  signal busy_buffercc_io_dataOut : std_logic;
  signal dropToggleStreamWire_buffercc_io_dataOut : std_logic;
  signal gearbox_io_input_ready : std_logic;
  signal gearbox_io_output_valid : std_logic;
  signal gearbox_io_output_payload : std_logic_vector(127 downto 0);

  signal ctrl_readErrorFlag : std_logic;
  signal ctrl_writeErrorFlag : std_logic;
  signal ctrl_readHaltRequest : std_logic;
  signal ctrl_writeHaltRequest : std_logic;
  signal ctrl_writeJoinEvent_valid : std_logic;
  signal ctrl_writeJoinEvent_ready : std_logic;
  signal ctrl_writeOccur : std_logic;
  signal ctrl_writeRsp_resp : std_logic_vector(1 downto 0);
  signal ctrl_writeJoinEvent_translated_valid : std_logic;
  signal ctrl_writeJoinEvent_translated_ready : std_logic;
  signal ctrl_writeJoinEvent_translated_payload_resp : std_logic_vector(1 downto 0);
  signal zz_ctrl_writeJoinEvent_translated_ready : std_logic;
  signal ctrl_writeJoinEvent_translated_haltWhen_valid : std_logic;
  signal ctrl_writeJoinEvent_translated_haltWhen_ready : std_logic;
  signal ctrl_writeJoinEvent_translated_haltWhen_payload_resp : std_logic_vector(1 downto 0);
  signal ctrl_writeJoinEvent_translated_haltWhen_halfPipe_valid : std_logic;
  signal ctrl_writeJoinEvent_translated_haltWhen_halfPipe_ready : std_logic;
  signal ctrl_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp : std_logic_vector(1 downto 0);
  signal ctrl_writeJoinEvent_translated_haltWhen_rValid : std_logic;
  signal ctrl_writeJoinEvent_translated_haltWhen_halfPipe_fire : std_logic;
  signal ctrl_writeJoinEvent_translated_haltWhen_rData_resp : std_logic_vector(1 downto 0);
  signal ctrl_readDataStage_valid : std_logic;
  signal ctrl_readDataStage_ready : std_logic;
  signal ctrl_readDataStage_payload_addr : unsigned(5 downto 0);
  signal ctrl_readDataStage_payload_prot : std_logic_vector(2 downto 0);
  signal io_axiLite_ar_rValid : std_logic;
  signal ctrl_readDataStage_fire : std_logic;
  signal io_axiLite_ar_rData_addr : unsigned(5 downto 0);
  signal io_axiLite_ar_rData_prot : std_logic_vector(2 downto 0);
  signal ctrl_readRsp_data : std_logic_vector(31 downto 0);
  signal ctrl_readRsp_resp : std_logic_vector(1 downto 0);
  signal zz_ctrl_readDataStage_ready : std_logic;
  signal ctrl_readDataStage_haltWhen_valid : std_logic;
  signal ctrl_readDataStage_haltWhen_ready : std_logic;
  signal ctrl_readDataStage_haltWhen_payload_addr : unsigned(5 downto 0);
  signal ctrl_readDataStage_haltWhen_payload_prot : std_logic_vector(2 downto 0);
  signal ctrl_readDataStage_haltWhen_translated_valid : std_logic;
  signal ctrl_readDataStage_haltWhen_translated_ready : std_logic;
  signal ctrl_readDataStage_haltWhen_translated_payload_data : std_logic_vector(31 downto 0);
  signal ctrl_readDataStage_haltWhen_translated_payload_resp : std_logic_vector(1 downto 0);
  signal ctrl_readAddressMasked : unsigned(5 downto 0);
  signal ctrl_writeAddressMasked : unsigned(5 downto 0);
  signal ctrl_readOccur : std_logic;
  signal busy : std_logic;
  signal done : std_logic;
  signal error : std_logic;
  signal durationCycles : unsigned(31 downto 0);
  signal time_AW_Accept : unsigned(31 downto 0);
  signal time_First_WData : unsigned(31 downto 0);
  signal time_B_Resp : unsigned(31 downto 0);
  signal time_Done : unsigned(31 downto 0);
  signal got_AW : std_logic;
  signal got_W : std_logic;
  signal got_B : std_logic;
  signal destAddr : unsigned(31 downto 0);
  signal sampleLength : unsigned(31 downto 0);
  signal samplesReceived : unsigned(19 downto 0);
  signal awBeatsIssued : unsigned(19 downto 0);
  signal wBeatsSent : unsigned(19 downto 0);
  signal validDropCount : unsigned(19 downto 0);
  signal startTrigger : std_logic;
  signal curAddress : unsigned(31 downto 0);
  signal remainingAWBeats : unsigned(31 downto 0);
  signal awRequests : unsigned(31 downto 0);
  signal bResponses : unsigned(31 downto 0);
  signal when_StreamToDdrPynq_l104 : std_logic;
  signal activeBurstLen : unsigned(8 downto 0);
  signal awValidReg : std_logic;
  signal maxBurst : unsigned(31 downto 0);
  signal bytesTo4K : unsigned(12 downto 0);
  signal boundBeats : unsigned(31 downto 0);
  signal zz_burstLen : unsigned(31 downto 0);
  signal burstLen : unsigned(31 downto 0);
  signal when_StreamToDdrPynq_l155 : std_logic;
  signal io_axi_aw_fire : std_logic;
  signal when_StreamToDdrPynq_l168 : std_logic;
  signal dropToggleStreamWire : std_logic;
  signal streamArea_busyCC : std_logic;
  signal streamArea_inValidPrev : std_logic;
  signal streamArea_dropToggleStream : std_logic;
  signal when_StreamToDdrPynq_l207 : std_logic;
  signal dropToggleCC : std_logic;
  signal dropToggleCCPrev : std_logic;
  signal when_StreamToDdrPynq_l222 : std_logic;
  signal io_pop_fire : std_logic;
  signal io_axi_w_fire : std_logic;
  signal when_StreamToDdrPynq_l249 : std_logic;
  signal io_axi_b_fire : std_logic;
  signal when_StreamToDdrPynq_l261 : std_logic;
  signal when_StreamToDdrPynq_l267 : std_logic;
  signal when_StreamToDdrPynq_l272 : std_logic;
  attribute keep_hierarchy of busy_buffercc : label is "TRUE";
  attribute keep_hierarchy of dropToggleStreamWire_buffercc : label is "TRUE";
begin
  axiLite_arready <= axiLite_arready_read_buffer;
  axiLite_rvalid <= axiLite_rvalid_read_buffer;
  axi_awvalid <= axi_awvalid_read_buffer;
  axi_wvalid <= axi_wvalid_read_buffer;
  axi_bready <= axi_bready_read_buffer;
  cdcFifo : entity work.StreamFifoCC_StreamToDdr_StreamDDR
    port map ( 
      io_push_valid => cdcFifo_io_push_valid,
      io_push_ready => cdcFifo_io_push_ready,
      io_push_payload => io_dataIn_payload,
      io_pop_valid => cdcFifo_io_pop_valid,
      io_pop_ready => gearbox_io_input_ready,
      io_pop_payload => cdcFifo_io_pop_payload,
      io_pushOccupancy => cdcFifo_io_pushOccupancy,
      io_popOccupancy => cdcFifo_io_popOccupancy,
      io_streamClk => io_streamClk,
      io_streamReset => io_streamReset,
      clk => clk 
    );
  busy_buffercc : entity work.BufferCC_3
    port map ( 
      io_dataIn => busy,
      io_dataOut => busy_buffercc_io_dataOut,
      io_streamClk => io_streamClk,
      io_streamReset => io_streamReset 
    );
  dropToggleStreamWire_buffercc : entity work.BufferCC_4
    port map ( 
      io_dataIn => dropToggleStreamWire,
      io_dataOut => dropToggleStreamWire_buffercc_io_dataOut,
      clk => clk,
      resetn => resetn 
    );
  gearbox : entity work.BitGearboxWrite_StreamDDR
    port map ( 
      io_input_valid => cdcFifo_io_pop_valid,
      io_input_ready => gearbox_io_input_ready,
      io_input_payload => cdcFifo_io_pop_payload,
      io_output_valid => gearbox_io_output_valid,
      io_output_ready => gearbox_io_output_ready,
      io_output_payload => gearbox_io_output_payload,
      clk => clk,
      resetn => resetn 
    );
  ctrl_readErrorFlag <= pkg_toStdLogic(false);
  ctrl_writeErrorFlag <= pkg_toStdLogic(false);
  ctrl_readHaltRequest <= pkg_toStdLogic(false);
  ctrl_writeHaltRequest <= pkg_toStdLogic(false);
  ctrl_writeOccur <= (ctrl_writeJoinEvent_valid and ctrl_writeJoinEvent_ready);
  ctrl_writeJoinEvent_valid <= (axiLite_awvalid and axiLite_wvalid);
  axiLite_awready <= ctrl_writeOccur;
  axiLite_wready <= ctrl_writeOccur;
  ctrl_writeJoinEvent_translated_valid <= ctrl_writeJoinEvent_valid;
  ctrl_writeJoinEvent_ready <= ctrl_writeJoinEvent_translated_ready;
  ctrl_writeJoinEvent_translated_payload_resp <= ctrl_writeRsp_resp;
  zz_ctrl_writeJoinEvent_translated_ready <= (not ctrl_writeHaltRequest);
  ctrl_writeJoinEvent_translated_haltWhen_valid <= (ctrl_writeJoinEvent_translated_valid and zz_ctrl_writeJoinEvent_translated_ready);
  ctrl_writeJoinEvent_translated_ready <= (ctrl_writeJoinEvent_translated_haltWhen_ready and zz_ctrl_writeJoinEvent_translated_ready);
  ctrl_writeJoinEvent_translated_haltWhen_payload_resp <= ctrl_writeJoinEvent_translated_payload_resp;
  ctrl_writeJoinEvent_translated_haltWhen_halfPipe_fire <= (ctrl_writeJoinEvent_translated_haltWhen_halfPipe_valid and ctrl_writeJoinEvent_translated_haltWhen_halfPipe_ready);
  ctrl_writeJoinEvent_translated_haltWhen_ready <= (not ctrl_writeJoinEvent_translated_haltWhen_rValid);
  ctrl_writeJoinEvent_translated_haltWhen_halfPipe_valid <= ctrl_writeJoinEvent_translated_haltWhen_rValid;
  ctrl_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp <= ctrl_writeJoinEvent_translated_haltWhen_rData_resp;
  axiLite_bvalid <= ctrl_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  ctrl_writeJoinEvent_translated_haltWhen_halfPipe_ready <= axiLite_bready;
  axiLite_bresp <= ctrl_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  ctrl_readDataStage_fire <= (ctrl_readDataStage_valid and ctrl_readDataStage_ready);
  axiLite_arready_read_buffer <= (not io_axiLite_ar_rValid);
  ctrl_readDataStage_valid <= io_axiLite_ar_rValid;
  ctrl_readDataStage_payload_addr <= io_axiLite_ar_rData_addr;
  ctrl_readDataStage_payload_prot <= io_axiLite_ar_rData_prot;
  zz_ctrl_readDataStage_ready <= (not ctrl_readHaltRequest);
  ctrl_readDataStage_haltWhen_valid <= (ctrl_readDataStage_valid and zz_ctrl_readDataStage_ready);
  ctrl_readDataStage_ready <= (ctrl_readDataStage_haltWhen_ready and zz_ctrl_readDataStage_ready);
  ctrl_readDataStage_haltWhen_payload_addr <= ctrl_readDataStage_payload_addr;
  ctrl_readDataStage_haltWhen_payload_prot <= ctrl_readDataStage_payload_prot;
  ctrl_readDataStage_haltWhen_translated_valid <= ctrl_readDataStage_haltWhen_valid;
  ctrl_readDataStage_haltWhen_ready <= ctrl_readDataStage_haltWhen_translated_ready;
  ctrl_readDataStage_haltWhen_translated_payload_data <= ctrl_readRsp_data;
  ctrl_readDataStage_haltWhen_translated_payload_resp <= ctrl_readRsp_resp;
  axiLite_rvalid_read_buffer <= ctrl_readDataStage_haltWhen_translated_valid;
  ctrl_readDataStage_haltWhen_translated_ready <= axiLite_rready;
  axiLite_rdata <= ctrl_readDataStage_haltWhen_translated_payload_data;
  axiLite_rresp <= ctrl_readDataStage_haltWhen_translated_payload_resp;
  process(ctrl_writeErrorFlag)
  begin
    if ctrl_writeErrorFlag = '1' then
      ctrl_writeRsp_resp <= pkg_stdLogicVector("10");
    else
      ctrl_writeRsp_resp <= pkg_stdLogicVector("00");
    end if;
  end process;

  process(ctrl_readErrorFlag)
  begin
    if ctrl_readErrorFlag = '1' then
      ctrl_readRsp_resp <= pkg_stdLogicVector("10");
    else
      ctrl_readRsp_resp <= pkg_stdLogicVector("00");
    end if;
  end process;

  process(ctrl_readAddressMasked,destAddr,sampleLength,busy,done,error,durationCycles,time_AW_Accept,time_First_WData,time_B_Resp,time_Done,samplesReceived,awBeatsIssued,wBeatsSent,validDropCount,cdcFifo_io_popOccupancy)
  begin
    ctrl_readRsp_data <= pkg_stdLogicVector("00000000000000000000000000000000");
    case ctrl_readAddressMasked is
      when "001000" =>
        ctrl_readRsp_data(31 downto 0) <= std_logic_vector(destAddr);
      when "001100" =>
        ctrl_readRsp_data(31 downto 0) <= std_logic_vector(sampleLength);
      when "000000" =>
        ctrl_readRsp_data(0 downto 0) <= pkg_toStdLogicVector(busy);
        ctrl_readRsp_data(1 downto 1) <= pkg_toStdLogicVector(done);
        ctrl_readRsp_data(2 downto 2) <= pkg_toStdLogicVector(error);
      when "000100" =>
        ctrl_readRsp_data(31 downto 0) <= std_logic_vector(durationCycles);
      when "010100" =>
        ctrl_readRsp_data(31 downto 0) <= std_logic_vector(time_AW_Accept);
      when "011000" =>
        ctrl_readRsp_data(31 downto 0) <= std_logic_vector(time_First_WData);
      when "011100" =>
        ctrl_readRsp_data(31 downto 0) <= std_logic_vector(time_B_Resp);
      when "100000" =>
        ctrl_readRsp_data(31 downto 0) <= std_logic_vector(time_Done);
      when "100100" =>
        ctrl_readRsp_data(19 downto 0) <= std_logic_vector(samplesReceived);
      when "101000" =>
        ctrl_readRsp_data(19 downto 0) <= std_logic_vector(awBeatsIssued);
      when "101100" =>
        ctrl_readRsp_data(19 downto 0) <= std_logic_vector(wBeatsSent);
      when "110000" =>
        ctrl_readRsp_data(19 downto 0) <= std_logic_vector(validDropCount);
      when "110100" =>
        ctrl_readRsp_data(10 downto 0) <= std_logic_vector(cdcFifo_io_popOccupancy);
      when others =>
    end case;
  end process;

  ctrl_readAddressMasked <= (ctrl_readDataStage_payload_addr and pkg_not(pkg_unsigned("000011")));
  ctrl_writeAddressMasked <= (axiLite_awaddr and pkg_not(pkg_unsigned("000011")));
  ctrl_readOccur <= (axiLite_rvalid_read_buffer and axiLite_rready);
  process(ctrl_writeAddressMasked,ctrl_writeOccur)
  begin
    startTrigger <= pkg_toStdLogic(false);
    case ctrl_writeAddressMasked is
      when "010000" =>
        if ctrl_writeOccur = '1' then
          startTrigger <= pkg_toStdLogic(true);
        end if;
      when others =>
    end case;
  end process;

  when_StreamToDdrPynq_l104 <= (startTrigger and (not busy));
  maxBurst <= pkg_unsigned("00000000000000000000000100000000");
  bytesTo4K <= (pkg_unsigned("1000000000000") - pkg_resize(pkg_extract(curAddress,11,0),13));
  boundBeats <= pkg_resize(pkg_shiftRight(bytesTo4K,4),32);
  zz_burstLen <= pkg_mux(pkg_toStdLogic(remainingAWBeats < maxBurst),remainingAWBeats,maxBurst);
  burstLen <= pkg_mux(pkg_toStdLogic(zz_burstLen < boundBeats),zz_burstLen,boundBeats);
  axi_awvalid_read_buffer <= awValidReg;
  axi_awaddr <= curAddress;
  axi_awid <= pkg_unsigned("0000");
  axi_awlen <= pkg_resize((burstLen - pkg_unsigned("00000000000000000000000000000001")),8);
  axi_awsize <= pkg_unsigned("100");
  axi_awburst <= pkg_stdLogicVector("01");
  axi_awcache <= pkg_stdLogicVector("0011");
  axi_awprot <= pkg_stdLogicVector("000");
  when_StreamToDdrPynq_l155 <= ((((busy and (not error)) and pkg_toStdLogic(remainingAWBeats /= pkg_unsigned("00000000000000000000000000000000"))) and pkg_toStdLogic(activeBurstLen = pkg_unsigned("000000000"))) and (not awValidReg));
  io_axi_aw_fire <= (axi_awvalid_read_buffer and axi_awready);
  when_StreamToDdrPynq_l168 <= (io_axi_aw_fire and (not got_AW));
  streamArea_busyCC <= busy_buffercc_io_dataOut;
  cdcFifo_io_push_valid <= (io_dataIn_valid and streamArea_busyCC);
  io_dataIn_ready <= (cdcFifo_io_push_ready and streamArea_busyCC);
  when_StreamToDdrPynq_l207 <= ((streamArea_busyCC and streamArea_inValidPrev) and (not io_dataIn_valid));
  dropToggleStreamWire <= streamArea_dropToggleStream;
  dropToggleCC <= dropToggleStreamWire_buffercc_io_dataOut;
  when_StreamToDdrPynq_l222 <= pkg_toStdLogic(dropToggleCC /= dropToggleCCPrev);
  axi_wvalid_read_buffer <= ((gearbox_io_output_valid and pkg_toStdLogic(activeBurstLen /= pkg_unsigned("000000000"))) and (not error));
  axi_wdata <= gearbox_io_output_payload;
  axi_wlast <= pkg_toStdLogic(activeBurstLen = pkg_unsigned("000000001"));
  axi_wstrb <= pkg_stdLogicVector("1111111111111111");
  gearbox_io_output_ready <= ((axi_wready and pkg_toStdLogic(activeBurstLen /= pkg_unsigned("000000000"))) and (not error));
  io_pop_fire <= (cdcFifo_io_pop_valid and gearbox_io_input_ready);
  io_axi_w_fire <= (axi_wvalid_read_buffer and axi_wready);
  when_StreamToDdrPynq_l249 <= (io_axi_w_fire and (not got_W));
  axi_bready_read_buffer <= pkg_toStdLogic(true);
  io_axi_b_fire <= (axi_bvalid and axi_bready_read_buffer);
  when_StreamToDdrPynq_l261 <= pkg_toStdLogic(axi_bresp /= pkg_stdLogicVector("00"));
  when_StreamToDdrPynq_l267 <= (((io_axi_b_fire and (not got_B)) and pkg_toStdLogic(awRequests = (bResponses + pkg_unsigned("00000000000000000000000000000001")))) and pkg_toStdLogic(remainingAWBeats = pkg_unsigned("00000000000000000000000000000000")));
  when_StreamToDdrPynq_l272 <= (((busy and pkg_toStdLogic(awRequests /= pkg_unsigned("00000000000000000000000000000000"))) and pkg_toStdLogic(bResponses = awRequests)) and pkg_toStdLogic(remainingAWBeats = pkg_unsigned("00000000000000000000000000000000")));
  process(clk, resetn)
  begin
    if resetn = '0' then
      ctrl_writeJoinEvent_translated_haltWhen_rValid <= pkg_toStdLogic(false);
      io_axiLite_ar_rValid <= pkg_toStdLogic(false);
      busy <= pkg_toStdLogic(false);
      done <= pkg_toStdLogic(false);
      error <= pkg_toStdLogic(false);
      durationCycles <= pkg_unsigned("00000000000000000000000000000000");
      time_AW_Accept <= pkg_unsigned("00000000000000000000000000000000");
      time_First_WData <= pkg_unsigned("00000000000000000000000000000000");
      time_B_Resp <= pkg_unsigned("00000000000000000000000000000000");
      time_Done <= pkg_unsigned("00000000000000000000000000000000");
      got_AW <= pkg_toStdLogic(false);
      got_W <= pkg_toStdLogic(false);
      got_B <= pkg_toStdLogic(false);
      destAddr <= pkg_unsigned("00000000000000000000000000000000");
      sampleLength <= pkg_unsigned("00000000000000000000000000000000");
      samplesReceived <= pkg_unsigned("00000000000000000000");
      awBeatsIssued <= pkg_unsigned("00000000000000000000");
      wBeatsSent <= pkg_unsigned("00000000000000000000");
      validDropCount <= pkg_unsigned("00000000000000000000");
      curAddress <= pkg_unsigned("00000000000000000000000000000000");
      remainingAWBeats <= pkg_unsigned("00000000000000000000000000000000");
      awRequests <= pkg_unsigned("00000000000000000000000000000000");
      bResponses <= pkg_unsigned("00000000000000000000000000000000");
      activeBurstLen <= pkg_unsigned("000000000");
      awValidReg <= pkg_toStdLogic(false);
      dropToggleCCPrev <= pkg_toStdLogic(false);
    elsif rising_edge(clk) then
      if ctrl_writeJoinEvent_translated_haltWhen_valid = '1' then
        ctrl_writeJoinEvent_translated_haltWhen_rValid <= pkg_toStdLogic(true);
      end if;
      if ctrl_writeJoinEvent_translated_haltWhen_halfPipe_fire = '1' then
        ctrl_writeJoinEvent_translated_haltWhen_rValid <= pkg_toStdLogic(false);
      end if;
      if axiLite_arvalid = '1' then
        io_axiLite_ar_rValid <= pkg_toStdLogic(true);
      end if;
      if ctrl_readDataStage_fire = '1' then
        io_axiLite_ar_rValid <= pkg_toStdLogic(false);
      end if;
      if when_StreamToDdrPynq_l104 = '1' then
        busy <= pkg_toStdLogic(true);
        done <= pkg_toStdLogic(false);
        error <= pkg_toStdLogic(false);
        durationCycles <= pkg_unsigned("00000000000000000000000000000000");
        awRequests <= pkg_unsigned("00000000000000000000000000000000");
        bResponses <= pkg_unsigned("00000000000000000000000000000000");
        curAddress <= destAddr;
        samplesReceived <= pkg_unsigned("00000000000000000000");
        awBeatsIssued <= pkg_unsigned("00000000000000000000");
        wBeatsSent <= pkg_unsigned("00000000000000000000");
        validDropCount <= pkg_unsigned("00000000000000000000");
        got_AW <= pkg_toStdLogic(false);
        got_W <= pkg_toStdLogic(false);
        got_B <= pkg_toStdLogic(false);
        time_AW_Accept <= pkg_unsigned("00000000000000000000000000000000");
        time_First_WData <= pkg_unsigned("00000000000000000000000000000000");
        time_B_Resp <= pkg_unsigned("00000000000000000000000000000000");
        time_Done <= pkg_unsigned("00000000000000000000000000000000");
        remainingAWBeats <= pkg_resize(pkg_shiftRight((pkg_shiftRight(((sampleLength * pkg_unsigned("100000000")) + pkg_unsigned("00000000000000000000000000000000000000111")),3) + pkg_unsigned("00000000000000000000000000000000001111")),4),32);
      end if;
      if busy = '1' then
        durationCycles <= (durationCycles + pkg_unsigned("00000000000000000000000000000001"));
      end if;
      if when_StreamToDdrPynq_l155 = '1' then
        awValidReg <= pkg_toStdLogic(true);
      end if;
      if io_axi_aw_fire = '1' then
        awValidReg <= pkg_toStdLogic(false);
        curAddress <= (curAddress + pkg_resize(pkg_shiftLeft(burstLen,4),32));
        remainingAWBeats <= (remainingAWBeats - burstLen);
        activeBurstLen <= pkg_resize(burstLen,9);
        awRequests <= (awRequests + pkg_unsigned("00000000000000000000000000000001"));
        awBeatsIssued <= (awBeatsIssued + pkg_resize(burstLen,20));
      end if;
      if when_StreamToDdrPynq_l168 = '1' then
        got_AW <= pkg_toStdLogic(true);
        time_AW_Accept <= durationCycles;
      end if;
      dropToggleCCPrev <= dropToggleCC;
      if when_StreamToDdrPynq_l222 = '1' then
        validDropCount <= (validDropCount + pkg_unsigned("00000000000000000001"));
      end if;
      if io_pop_fire = '1' then
        samplesReceived <= (samplesReceived + pkg_unsigned("00000000000000000001"));
      end if;
      if io_axi_w_fire = '1' then
        activeBurstLen <= (activeBurstLen - pkg_unsigned("000000001"));
        wBeatsSent <= (wBeatsSent + pkg_unsigned("00000000000000000001"));
      end if;
      if when_StreamToDdrPynq_l249 = '1' then
        got_W <= pkg_toStdLogic(true);
        time_First_WData <= durationCycles;
      end if;
      if io_axi_b_fire = '1' then
        bResponses <= (bResponses + pkg_unsigned("00000000000000000000000000000001"));
        if when_StreamToDdrPynq_l261 = '1' then
          error <= pkg_toStdLogic(true);
          busy <= pkg_toStdLogic(false);
        end if;
      end if;
      if when_StreamToDdrPynq_l267 = '1' then
        got_B <= pkg_toStdLogic(true);
        time_B_Resp <= durationCycles;
      end if;
      if when_StreamToDdrPynq_l272 = '1' then
        busy <= pkg_toStdLogic(false);
        done <= pkg_toStdLogic(true);
        time_Done <= durationCycles;
      end if;
      case ctrl_writeAddressMasked is
        when "001000" =>
          if ctrl_writeOccur = '1' then
            destAddr <= unsigned(pkg_extract(axiLite_wdata,31,0));
          end if;
        when "001100" =>
          if ctrl_writeOccur = '1' then
            sampleLength <= unsigned(pkg_extract(axiLite_wdata,31,0));
          end if;
        when others =>
      end case;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if ctrl_writeJoinEvent_translated_haltWhen_ready = '1' then
        ctrl_writeJoinEvent_translated_haltWhen_rData_resp <= ctrl_writeJoinEvent_translated_haltWhen_payload_resp;
      end if;
      if axiLite_arready_read_buffer = '1' then
        io_axiLite_ar_rData_addr <= axiLite_araddr;
        io_axiLite_ar_rData_prot <= axiLite_arprot;
      end if;
    end if;
  end process;

  process(io_streamClk, io_streamReset)
  begin
    if io_streamReset = '0' then
      streamArea_inValidPrev <= pkg_toStdLogic(false);
      streamArea_dropToggleStream <= pkg_toStdLogic(false);
    elsif rising_edge(io_streamClk) then
      streamArea_inValidPrev <= io_dataIn_valid;
      if when_StreamToDdrPynq_l207 = '1' then
        streamArea_dropToggleStream <= (not streamArea_dropToggleStream);
      end if;
    end if;
  end process;

end arch;

