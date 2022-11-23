class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.10.5"
    checksums = {
        "darwin_arm64" => "0e8b754728ec4777fd6fbacd347b69eae789e2e188645211543eb895037140d3",
        "darwin_amd64" => "707881cf0935d1617ced46d720064f338577dad919dd8f73af0271eb7d0ed205",
        "linux_arm64"  => "1bb58fa95fc24a39bc267a183ff0ccfdebc0ad3e24e70099eca59220594116ea",
        "linux_amd64"  => "6f98afc6efe579a736f66eaced85adf42df1d6c04e9cadf66424c3b74a5a4f5a",
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
