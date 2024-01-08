use proc_macro::TokenStream;
use quote::quote;
use syn::{parse_macro_input, Ident};
#[proc_macro]
pub fn generate_single_package_manager_json_struct(input: TokenStream) -> TokenStream {
    // Parse the input as an identifier
    let input = parse_macro_input!(input as Ident);
    let struct_name = generate_struct_name(&input);

    // Generate the output code using the quote macro
    let expanded = quote! {
        #[derive(Debug, PartialEq, Eq, Deserialize, Serialize)]
        pub struct #struct_name {
            pub #input: ::std::collections::HashMap<String, String>,
        }
    };

    // Convert the generated code to a TokenStream and return it
    TokenStream::from(expanded)
}

fn generate_struct_name(ident: &Ident) -> Ident {
    let capitalized_ident = ident.to_string()[..1].to_uppercase() + &ident.to_string()[1..];
    let struct_name_str = format!("{}Json", capitalized_ident);
    Ident::new(&struct_name_str, ident.span())
}

/*

package_manager!(pacman);

// Generates below code:

struct PacmanJson {
    pacman: ::std::collections::HashMap<String, String>,
}

*/

#[proc_macro]
pub fn generate_single_package_manager_function(input: TokenStream) -> TokenStream {
    // Parse the input as an identifier
    let input = parse_macro_input!(input as Ident);
    let struct_name = generate_struct_name(&input);
    let uppercase_name = Ident::new(&input.to_string()[..].to_uppercase(), input.span());
    let function_name = Ident::new(&format!("fetch_{}", input), input.span());

    // Generate the output code using the quote macro
    let expanded = quote! {
        pub fn #function_name() -> Result<#struct_name> {
            let file_json = File::open(files::#uppercase_name).context("Couldn't open file database")?;
            let mut buf_reader = BufReader::new(file_json);
            let mut json_buf = String::with_capacity(500);

            buf_reader
                .read_to_string(&mut json_buf)
                .context("Couldn't read buffer to String")?;

            // Parse the string of data into a MIR Representation
            let result: #struct_name = serde_json::from_str(&json_buf)?;

            Ok(result)
        }
    };

    // Convert the generated code to a TokenStream and return it
    TokenStream::from(expanded)
}

/*

package_manager_function!(pacman);

pub fn fetch_pacman() -> Result<()> {
    let file_json = File::open(files::PACMAN).context("Couldn't open file database")?;
    let mut buf_reader = BufReader::new(file_json);
    let mut json_buf = String::with_capacity(500);

    buf_reader
        .read_to_string(&mut json_buf)
        .context("Couldn't read buffer to String")?;

    // Parse the string of data into a MIR Representation
    let pacman_json: PacmanJson = serde_json::from_str(&json_buf)?;

    Ok(pacman_json)
}

*/
