class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230219"
    checksums = {
        "darwin_arm64" => "3784a9f9cbc3ab12bd45afaed69bea49c0ead64766e3b97cf241d1d4c6621b93",
        "darwin_amd64" => "f6c5f5eba4e35a9b1cb21019413f4ac9e3487bfa72198ce75064a243706d4241",
        "linux_arm64"  => "53707615e0f9dccba94ac432630eadd00edead1fb7f9d76ca59d81b7998dc5a7",
        "linux_amd64"  => "9cadf1917c73e659ee3db84582e2914460550c290fbd6539dfb7351054e3665a",
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
