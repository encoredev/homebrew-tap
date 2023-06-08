class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230608"
    checksums = {
        "darwin_arm64" => "f4b9e4c8760ad49cd17a342067383e55ae733ed6069b003276b97dd07f284dc3",
        "darwin_amd64" => "a18731fab60e9ba95b279994d25fe3b29806502229ddbebd807f25237ae86a50",
        "linux_arm64"  => "e0b185ded28d734ed6367d52bd92a5689c8432266f1cb9720d8d90ba138bb0b1",
        "linux_amd64"  => "eb3afdcec2a9075a6f93ae5b2ed26b57e650a12899dea22d0a488419275e0e8a",
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
