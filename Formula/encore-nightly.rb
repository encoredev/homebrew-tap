class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230603"
    checksums = {
        "darwin_arm64" => "dc25b364c2def70a2768cd2cf7b738d747f0190a41a37ed5a240fb0c1b086f60",
        "darwin_amd64" => "fea33bcc7a2382a33378d31bd5810b3042e7155436c5e4659f47c93872092eb4",
        "linux_arm64"  => "162913a89e58e8ebeb76ac37e0ef81f6e5aac35bddafda9203a2450c5d8d005c",
        "linux_amd64"  => "3f8cc4d52dedd33e947310faac1c8b64c413206643185f8815e51c803dce945c",
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
