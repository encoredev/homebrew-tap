class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231207"
    checksums = {
        "darwin_arm64" => "8b3cdbf96e29f483e78a1b2259608758f55df3ef749b19a3f735d5fee45c5535",
        "darwin_amd64" => "776a3af0c812813b847de38f1f47162b28a49830f1d7501ea36486c404da5dce",
        "linux_arm64"  => "9129d476da06bbd4895174842bcf6c7c35a9f26ac9d3c27ab775b145b60f12c6",
        "linux_amd64"  => "630387d726576ee185d54b3ce027e0fc801190b2a64bb0e05680974be370d3e4",
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

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
