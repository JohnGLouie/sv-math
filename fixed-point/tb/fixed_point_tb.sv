/*  Unit Tests for Fixed-point Arithemetic Package
 *
 *  Description:
 *      Units tests for the fixed-point arithemtic package.
 *
 *  Synthesizable:
 *      No.
 *
 *  References:
 *      None.
 *
 *  Notes:
 *      None.
 *
 */

import fixed_point::*;

module fixed_point_tb();

    FixedPoint a;
    FixedPoint b;
    FixedPoint c;

    function void test_convert();
        FixedPoint a;
        a = '{
            M : 15,
            Q : 16,
            value : 64'h3fff_ffff_ffff_ffff
        };

        // Test convert(), increase M
        a = convert(a, 16, 16);
        assert(a.M == 16) else $error("Failed to increase M: Incorrect M.");
        assert(a.Q == 16) else $error("Failed to increase M: Incorrect Q.");
        assert(a.value == 64'h1fff_ffff_ffff_ffff) else $error("Failed to increase M: Incorrect value.");

        // Test convert(), decrease M
        a = convert(a, 15, 16);
        assert(a.M == 15) else $error("Failed to decrease M: Incorrect M.");
        assert(a.Q == 16) else $error("Failed to decrease M: Incorrect Q.");
        assert(a.value == 64'h3fff_ffff_ffff_fffe) else $error("Failed to decrease M: Incorrect value.");

        // Test convert(), increase Q
        a = convert(a, 15, 17);
        assert(a.M == 15) else $error("Failed to increase Q: Incorrect M.");
        assert(a.Q == 17) else $error("Failed to increase Q: Incorrect Q.");
        assert(a.value == 64'h3fff_ffff_ffff_fffe) else $error("Failed to increase Q: Incorrect value.");

        // Test convert(), decrease Q
        a = convert(a, 15, 16);
        assert(a.M == 15) else $error("Failed to decrease Q: Incorrect M.");
        assert(a.Q == 16) else $error("Failed to decrease Q: Incorrect Q.");
        assert(a.value == 64'h3fff_ffff_ffff_fffe) else $error("Failed to decrease Q: Incorrect value.");
    endfunction

    function void test_add();
        FixedPoint a;
        FixedPoint b;
        FixedPoint c;

        a = '{
            M : 15,
            Q : 16,
            value : 64'h3fff_ffff_ffff_ffff
        };

        b = '{
            M : 15,
            Q : 16,
            value : 64'h4000_0000_0000_0000
        };

        // Test addition with same format.
        c = add(a, b);
        assert(c.M == 15) else $error("Failed to add values: Incorrect M.");
        assert(c.Q == 16) else $error("Failed to add values: Incorrect Q.");
        assert(c.value == 64'h7fff_ffff_ffff_ffff) else $error("Failed to add values: Incorrect value.");
    endfunction

	function void test_subtract();
        FixedPoint a;
        FixedPoint b;
        FixedPoint c;

        a = '{
            M : 15,
            Q : 16,
            value : 64'h4000_0000_0000_0000
        };

        b = '{
            M : 15,
            Q : 16,
            value : 64'h3fff_ffff_ffff_ffff
        };

        // Test addition with same format.
        c = subtract(a, b);
        assert(c.M == 15) else $error("Failed to subtract values: Incorrect M.");
        assert(c.Q == 16) else $error("Failed to subtract values: Incorrect Q.");
        assert(c.value == 64'h0000_0000_0000_0001) else $error("Failed to subtract values: Incorrect value.");
    endfunction

    function void test_mult();
        FixedPoint a;
        FixedPoint b;
        FixedPoint c;

        a = '{
            M : 15,
            Q : 16,
            value : 64'h0003_0000_0000_0000
        };

        b = '{
            M : 15,
            Q : 16,
            value : 64'h0002_0000_0000_0000
        };

        // Test multiply with same format.
        c = mult(a, b);
        assert(c.M == 30) else $error("Failed to multiply values: Incorrect M.");
        assert(c.Q == 16) else $error("Failed to multiply values: Incorrect Q.");
        assert(c.value == 64'h0000_000C_0000_0000) else $error("Failed to multiply values: Incorrect value.");
    endfunction

    initial
        begin

        // Test convert()
        test_convert();

        // Test add()
        test_add();

        // TODO: Test subtract with same format.

        // Test mult()
        test_mult();

        // TODO: Test non-same format.

    end

endmodule
