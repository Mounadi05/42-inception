<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME',  getenv('DB_DATABASE'));

/** Database username */
define( 'DB_USER', getenv('DB_USER') );

/** Database password */
define( 'DB_PASSWORD', getenv('DB_USER_PASSWORD') );

/** Database hostname */
define( 'DB_HOST', getenv('DB_HOST'));

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
 
 define('AUTH_KEY',         'n<C##|uAeF38aK-zS{j!BA(}zIT-*WC-:<KH =P`[qb)/}dr!)$Oeb/-HAVg+<SY');
 define('SECURE_AUTH_KEY',  'E>>#Z-P8%)sQ+x.m=vf.N*kF Sjy>36[6by7?!*2/C5kL$:b8TeT@&2g!w+l_kE+');
 define('LOGGED_IN_KEY',    '0C4X*@BX|Tx}Ds}Rr[f TYT+8[ o,%*Y}Sybnu!ja.I-O&J>{X+E%BQ[-[#$!LA(');
 define('NONCE_KEY',        '^^Bp+/-L2zheWSJRLTjm^(5(Jnzvgq!.i*(Kq^` NNis5Odn9[4_yj!dV3e2xLQ1');
 define('AUTH_SALT',        'c:=9^yr%@]|{k-IO`]sA|KPd69t=K/y-zS-7~w`ee|-GMgx(;T|65c@<yaA,E#Vo');
 define('SECURE_AUTH_SALT', 'J5)nHe@!Sw-nczWgotMsOhrV!N#-}Iz.Qe(_Yicm2ZTJ(-1>-nl c=+taJZ|jb+-');
 define('LOGGED_IN_SALT',   '<-,:V$#5S~kWRI6@ekDy<%IQ+4@^Z ^2(-M+U-DD[w=`=vKm`H&4h|%!fYxn(4M4');
 define('NONCE_SALT',       'dMo9x@3Zh =!~$}j~DUqRO_!n(Cqhx9eyv8l:-Ni^v)9A_Q+dwFt%n[+d93%l^h{');
/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
