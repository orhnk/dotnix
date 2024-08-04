/// Generate package manager json structs based on the inputs provided.
#[macro_export]
macro_rules! package_manager_json {
     ($a:ident) => {
        ::proc::generate_single_package_manager_json_struct!($a);
     };

    ($($a:ident),*) => {
        $(
            ::proc::generate_single_package_manager_json_struct!($a);
        )*
    };

    {} => {
        ::std::compile_error!("macro `package_manager` takes at least an arguments");
    }
}

#[macro_export]
macro_rules! package_manager_function {
     ($a:ident) => {
        ::proc::generate_single_package_manager_function!($a);
     };

    ($($a:ident),*) => {
        $(
            ::proc::generate_single_package_manager_function!($a);
        )*
    };

    {} => {
        ::std::compile_error!("macro `package_manager` takes at least an arguments");
    }
}

#[macro_export]
macro_rules! package_manager_enum {
    ($a:ident) => {
        $a,
    };

    ($($a:ident),*) => {
        enum MergePackageManager {
        $(
            $a,
        )*
        }
    };

    {} => {
        ::std::compile_error!("macro `package_manager` takes at least an arguments");
    }
}

pub use package_manager_function;
pub use package_manager_json;
