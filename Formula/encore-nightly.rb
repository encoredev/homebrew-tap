class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230607"
    checksums = {
        "darwin_arm64" => "b63477ce6c9a04661d2fc69cd3649ec5bdc669702a59c571eab8431bb7c64481",
        "darwin_amd64" => "e28efa9a86646feb9112aac8f955dfa9ede68eafc4268d2e9a411b47b2b275e3",
        "linux_arm64"  => "c1a23206b8f92b23c1b69062890fdc13569f46da5b832b8c26321def20dde290",
        "linux_amd64"  => "f764db3bf0e9175514bf7867aec0048fbbdd7de65e0663bfc8a99b1642489af7",
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
