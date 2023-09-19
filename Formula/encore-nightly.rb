class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230919"
    checksums = {
        "darwin_arm64" => "4480d64f23ea700cb1c3d055b6924dfe08e1b0aa48d81dc69f85f619aa305cb2",
        "darwin_amd64" => "c7709c1e8efeaf9607f1d84b57954a54f65a1813a3a8aeb7c2bfa54335a22c76",
        "linux_arm64"  => "b25c8d5a80e078c6d7c91ace4a288afa96c820a935d733196d86a35eff2bbe7e",
        "linux_amd64"  => "a57c91abe560903ec0ca209abc91f19e91806f44c6bd688037984816a48257ca",
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
