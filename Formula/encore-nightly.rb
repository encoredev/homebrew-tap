class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230317"
    checksums = {
        "darwin_arm64" => "48e8f4f8f1a010f268937cb1aafd9bd359b10ec6c1c87015ecee751378b3cabc",
        "darwin_amd64" => "b0e7852cb9c4a1b89c9e75116a8cf11362f14a72fb32bd1dc4049bc858e7da0d",
        "linux_arm64"  => "e301b479e794997b28aae8dc97619be887de058e442fe2805778d8916c9fe7c7",
        "linux_amd64"  => "46349d44c2c2978d612d12efabf60e97800ecb5c08b766870e810bcafebe1658",
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
