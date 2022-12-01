#include <catch2/catch_all.hpp>

#include <infinity_core/math.hpp>

using namespace qone;

TEST_CASE( "fuzzyCompare", "[math, fuzzy_compare]" ) {
    CHECK( math::fuzzyCompare<float>( 2.34567899304F, 2.345678993040009F ) );
    CHECK( math::fuzzyCompare<double>( 2.34567899304, 2.3456789930400000009 ) );
}

TEST_CASE( "maxBitDepthValue", "[math, fuzzy_compare]" ) {
    SECTION( "Valor de 8 bits" ) {
        REQUIRE( math::maxBitDepthValue( 8 ) == 255 );
    }
    SECTION( "Valor de 16 bits" ) {
        REQUIRE( math::maxBitDepthValue( 16 ) == 65535 );
    }
}

TEST_CASE( "clamp", "[math, clamp]" ) {
    REQUIRE( math::clamp<double>( 35.0, 0.0, 100.0 ) == Catch::Approx( 35.0 ) );
    REQUIRE( math::clamp<int>( 35, 0, 100 ) == 35 );
    REQUIRE( math::clamp<int>( 500, 0, 100 ) == 100 );
    REQUIRE( math::clamp<int>( -50, 0, 100 ) == 0 );
    REQUIRE_FALSE( math::clamp<int>( -50, 0, 100 ) == 10 );
}

TEST_CASE( "smoothstep", "[math, smoothstep]" ) {
    SECTION( "Smoothstep Double" ) {
        REQUIRE( math::smoothstep<double>( 0.345 ) == Catch::Approx( 0.27494775 ) );
    }
    SECTION( "Smoothstep Float" ) {
        REQUIRE( math::smoothstep<float>( 0.345F ) == Catch::Approx( 0.27494775F ) );
    }
}

TEST_CASE( "smoothstep with clamp", "[math, smoothstep]" ) {
    SECTION( "Smoothstep Clamped Double" ) {
        REQUIRE( math::smoothstep<double>( 0.345, 0, 1 ) == Catch::Approx( 0.27494775 ) );
    }
    SECTION( "Smoothstep Clamped Float" ) {
        REQUIRE( math::smoothstep<float>( 0.345F, 0.0F, 1.0F ) == Catch::Approx( 0.27494775F ) );
    }
}

TEST_CASE( "smoothstep inverse", "[math, fuzzy_compare]" ) {
    //    REQUIRE( math::fuzzyCompare<double>( math::smoothstep_inverse<double>( 0.345 ), 0.27494775 ) );
    //    REQUIRE( math::fuzzyCompare<float>( math::smoothstep_inverse<float>( 0.345F ), 0.27494775F ) );
}

TEST_CASE( "lerp", "[math, lerp]" ) {
    SECTION( "Linear Interpolation Double" ) {
        REQUIRE( math::lerp<double>( 0.25, 0.0, 100.0 ) == Catch::Approx( 25.0 ) );
    }

    SECTION( "Linear Interpolation Float" ) {
        REQUIRE( math::lerp<float>( 0.25F, 0.0F, 100.0F ) == Catch::Approx( 25.0F ) );
    }
}

TEST_CASE( "inverseLerp", "[math, inverse, lerp]" ) {
    SECTION( "Inverse Linear Interpolation Double" ) {
        REQUIRE( math::inverseLerp<double>( 25.0, 0.0, 100.0 ) == Catch::Approx( 0.25 ) );
    }

    SECTION( "Inverse Interpolation Float" ) {
        REQUIRE( math::inverseLerp<float>( 25.0F, 0.0F, 100.0F ) == Catch::Approx( 0.25F ) );
    }
}

TEST_CASE( "remap", "[math, remap, inverse, lerp]" ) {
    SECTION( "Linear Interpolation Double" ) {
        REQUIRE( math::remap<double>( 25.0, 0.0, 100.0, 0.0, 1.0 ) == Catch::Approx( 0.25 ) );
        REQUIRE( math::remap<double>( 0.23, 0.0, 1.0, 0.0, 100.0 ) == Catch::Approx( 23.0 ) );
    }

    SECTION( "Linear Interpolation Float" ) {
        REQUIRE( math::remap<float>( 25.0F, 0.0F, 100.0F, 0.0F, 1.0F ) == Catch::Approx( 0.25F ) );
        REQUIRE( math::remap<float>( 0.23F, 0.0F, 1.0F, 0.0F, 100.0F ) == Catch::Approx( 23.0F ) );
    }
}
