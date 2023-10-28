class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231028"
    checksums = {
        "darwin_arm64" => "e119a9cdaf06e7677e2591275dc79ce951bfd212c36eff7cb71fadd60d70886f",
        "darwin_amd64" => "a3bde01f513aad5baf7b3f085f4877d84aa7f56ecc405b32919ecccea68593db",
        "linux_arm64"  => "17106599ce32f2f179486c808a10c0bc97e17ef2adf44dac5eea9760f7cfc533",
        "linux_amd64"  => "9b0079559432c9dc3ac24507dc919d1b01f8d9eb40978515070b278ae7a44b0a",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
